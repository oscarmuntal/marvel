//
//  ApiRequestBuilder.swift
//  Marvel
//
//  Created by Òscar Muntal on 1/2/23.
//

import Foundation
import Alamofire

public protocol ApiRequestBuilder {
    func buildRequest(apiCall: ApiCall) throws -> URLRequest
}

public struct UniversalApiRequestBuilder: ApiRequestBuilder {
    let encoding: ParameterEncoding
    
    public func buildRequest(apiCall: ApiCall) throws -> URLRequest {
        guard let apiBaseUrl = apiCall.baseUrl, var url = URL(string: apiBaseUrl) else {
            throw NetworkManagerError.missingApiBaseUrl
        }
        
        url.appendPathComponent(apiCall.path)
        
        var request = URLRequest(url: url)
        
        request.httpMethod = apiCall.verb.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        apiCall.extraHeaders?.forEach({
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        })
        
        let encoding: ParameterEncoding = {
            switch apiCall.verb {
            case .GET:
                return URLEncoding.default
            default:
                return self.encoding
            }
        }()
        
        return try encoding.encode(request, with: apiCall.params)
    }
}

public extension UniversalApiRequestBuilder {
    static var jsonRequest: ApiRequestBuilder { UniversalApiRequestBuilder(encoding: JSONEncoding.default) }
    static var queryStringRequest: ApiRequestBuilder { UniversalApiRequestBuilder(encoding: URLEncoding.queryString) }
    static var httpBodyRequest: ApiRequestBuilder { UniversalApiRequestBuilder(encoding: URLEncoding.httpBody) }
}
