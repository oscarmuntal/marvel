//
//  ApiRouter.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import Alamofire
import Combine

public enum MarvelError: Error {
    case charactersListError(String)
    case characterNotFound
    case other
    
    var title: String { errorAlertTitleAndMessage().0 }
    var message: String { errorAlertTitleAndMessage().1 }
    
    func errorAlertTitleAndMessage() -> (String, String) {
        switch self {
        case .charactersListError(let message): return (charactersListErrorTitle, message)
        case .characterNotFound: return (characterNotFoundTitle, characterNotFoundMessage)
        case .other:  return (genericErrorTitle, genericErrorMessage)
        }
    }
    
    var charactersListErrorTitle: String { "Failed at loading the characters" }
    var characterNotFoundTitle: String { "Failed at loading this character" }
    var characterNotFoundMessage: String { "The character you have chosen is temporarily unavailable, please try again later or choose another super hero" }
    var genericErrorTitle: String { "Something has failed" }
    var genericErrorMessage: String { "Please, try again in a few minutes" }
}

public protocol ApiRouting {
    func requestDecodable<T: Decodable>(_ apiCall: ApiCall, _ completion: @escaping (Result<T, MarvelError>) -> Void)
    func requestDecodablePublisher<T: Decodable>(_ apiCall: ApiCall) -> AnyPublisher<T, MarvelError>
}

public class ApiRouter: ApiRouting {
    public struct Empty: Decodable {}
    public static let shared = ApiRouter()
    private let networkManager: NetworkManager
    
    public convenience init() {
        self.init(networkManager: NetworkServer())
    }
    
    init(networkManager: NetworkManager = NetworkServer()) {
        self.networkManager = networkManager
    }
    
    public func requestDecodable<T: Decodable>(_ apiCall: ApiCall, _ completion: @escaping (Result<T, MarvelError>) -> Void) {
        do {
            let urlRequest = try apiCall.buildRequest()
            self.networkManager.request(urlRequest) { result, statusCode in
                completion(.success(result))
            } onError: { error, statusCode, data in
                guard let statusCode = statusCode, let data = data else {
                    completion(.failure(.other))
                    return
                }
                completion(.failure(self.marvelError(statusCode: statusCode, data: data)))
            }
        } catch (let error) {
            completion(.failure(error as! MarvelError))
        }
    }
    
    public func requestDecodablePublisher<T: Decodable>(_ apiCall: ApiCall) -> AnyPublisher<T, MarvelError> {
        Deferred {
            Future { [weak self] promise in
                self?.requestDecodable(apiCall) { (result: Result<T, MarvelError>) in
                    switch result {
                    case .success(let data):
                        promise(.success(data))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func charactersListErrorMessage(by data: Data) -> String {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String : Any],
              let status = json["status"] as? String else { return "" }
        return status
    }
    
    func marvelError(statusCode: Int, data: Data) -> MarvelError {
        switch statusCode {
        case 404: return .characterNotFound
        case 409: return .charactersListError(charactersListErrorMessage(by: data))
        default: return .other
        }
    }
}
