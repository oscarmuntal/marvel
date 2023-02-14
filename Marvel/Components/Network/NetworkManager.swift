//
//  NetworkManager.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import Alamofire

protocol NetworkManager {
    func request<T: Decodable>(_ urlRequest: URLRequest,
                                      onSuccess: @escaping (T, Int?) -> Void,
                                      onError: @escaping (Error, Int?, Data?) -> Void)
}

public enum NetworkManagerError: Error {
    case missingApiBaseUrl
}

class NetworkServer: NetworkManager {
    private let session: Session
    
    init(session: Session = AF) {
        self.session = session
    }
    
    func request<T: Decodable>(_ urlRequest: URLRequest,
                                      onSuccess: @escaping (T, Int?) -> Void,
                                      onError: @escaping (Error, Int?, Data?) -> Void) {
        session
            .request(urlRequest)
            .responseDecodable { (dataResponse: DataResponse<T, AFError>) in
                switch dataResponse.result {
                case .success(let result):
                    onSuccess(result, dataResponse.response?.statusCode)
                case .failure(let error):
                    onError(error, self.parseError(error: error, statusCode: dataResponse.response?.statusCode), dataResponse.data)
                }
            }
            .validate()
    }
    
    private func parseError(error: AFError, statusCode: Int?) -> Int {
        switch error {
        case .sessionTaskFailed(_): return -1009
        default: break
        }
        guard let statusCode = statusCode else { return 0 }
        return statusCode
    }
}
