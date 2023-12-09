//
//  NetworkManager.swift
//  DigitalFlakeAssignment
//
//  Created by mahesh gaykar on 08/12/23.
//

import Alamofire
import Foundation

open class NetworkManager {
    public static let shared: NetworkManager = {
        return NetworkManager()
    }()
    public typealias completionHandler = ((Result<Data, Error>) -> Void)
    public var request: Alamofire.Request?
    
    public func request(_ url: String, method: HTTPMethod = .post, parameters: Parameters? = nil,
                     encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, completion: @escaping completionHandler){
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().response { (response) in
            if let data = response.data {
                completion(.success(data))
            } else {
                completion(.failure(response.error!))
            }
        }
    }
}

public struct JSONArrayEncoding: ParameterEncoding {
    private let array: [Parameters]
    public init(array: [Parameters]) {
        self.array = array
    }
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        let data = try JSONSerialization.data(withJSONObject: array, options: [])
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        urlRequest.httpBody = data
        return urlRequest
    }
}

public struct JSONDataEncoding: ParameterEncoding {
    private let val: Parameters
    public init(val: Parameters) {
        self.val = val
    }
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        let data = try JSONSerialization.data(withJSONObject: val, options: [])
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        urlRequest.httpBody = data
        return urlRequest
    }
}
