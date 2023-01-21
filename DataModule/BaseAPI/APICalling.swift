//
//  APICalling.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation
import SystemConfiguration
import Combine

class APICalling {
        
    func fetch<T: Codable>(apiRequest: APIRequest) -> AnyPublisher<T, Error> {
        
        let request = apiRequest.request(with: apiRequest.baseURL)
        
        let urlConfiguration = URLSessionConfiguration.default
        urlConfiguration.waitsForConnectivity = true
        urlConfiguration.timeoutIntervalForRequest = 12
        urlConfiguration.timeoutIntervalForResource = 12
        
        return URLSession(configuration: urlConfiguration)
            .dataTaskPublisher(for: request).map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
