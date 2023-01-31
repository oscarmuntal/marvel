//
//  MarvelApi.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import Alamofire

public enum ApiVerb: String {
    case GET, POST, PUT, PATCH, DELETE
}

public protocol ApiCall {
    var baseUrl: String? { get }
    var extraHeaders: [String: String]? { get }
    var verb: ApiVerb { get }
    var path: String { get }
    var params: [String: String]? { get }
    var key: String { get }
    var currentTime: TimeInterval { get }
    func hashMd5(timeStamp: String) -> String
    var requestBuilder: ApiRequestBuilder { get }
}

public extension ApiCall {
    var params: [String: String]? { nil }
    var requestBuilder: ApiRequestBuilder { UniversalApiRequestBuilder.jsonRequest }
    
    func buildRequest() throws -> URLRequest {
        try requestBuilder.buildRequest(apiCall: self)
    }
}

enum MarvelApi: ApiCall {
    case
    characters(offset: String),
    characterDetail(id: Int)
    
    var baseUrl: String? { Bundle.main.apiUrl }
    var extraHeaders: [String : String]? { nil }
    
    var verb: ApiVerb {
        switch self {
        case .characters, .characterDetail: return .GET
        }
    }
    
    var path: String {
        switch self {
        case .characters: return "/v1/public/characters"
        case .characterDetail(let id): return "/v1/public/characters/\(id)"
        }
    }
    
    var params: [String : String]? {
        switch self {
        case .characters(let offset):
            let timeStamp = String(currentTime)
            return ["apikey": key, "ts": timeStamp, "hash": hashMd5(timeStamp: timeStamp), "offset": offset]
        case .characterDetail:
            let timeStamp = String(currentTime)
            return ["apikey": key, "ts": timeStamp, "hash": hashMd5(timeStamp: timeStamp)]
        }
    }
    
    var key: String { publicKey }
    var currentTime: TimeInterval { Date().timeIntervalSince1970 }
    func hashMd5(timeStamp: String) -> String {
        return (timeStamp + privateKey + publicKey).MD5
    }
}

