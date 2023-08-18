//
//  File.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

public class APIRequest {
    var baseURL: URL!
    var method = "GET"
    var parameters = [String: String]()
    
    public init(method: String = "GET",
                parameters: [String : String] = [String: String]()) {
        self.method = method
        self.parameters = parameters
    }
    
    func updateBaseURL(_ url: URL) {
        baseURL = url
    }
    
    func request() -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method
        request.allHTTPHeaderFields = ["Accept" : "application/json"]
        return request
    }
}
