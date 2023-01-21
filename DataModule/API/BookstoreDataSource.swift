//
//  BookstoreDataSource.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

public class BookstoreDataSource {
    
    public static let shared = BookstoreDataSource()
    private var token = CancelBag()
    private let url = "volumes?q=ios&maxResults=20&startIndex=%i"
    
    let URLDefault = APIStrings.baseUrl
        
    public func booksFetch(_ page: Int, callBack: @escaping (Result<Bookstore, Error>) -> Void) {
        
        let apiRequest = APIRequest()
        let urlString = String(format: "\(URLDefault)\(url)", page)
        apiRequest.baseURL = URL(string: urlString)
        
        APICalling().fetch(apiRequest: apiRequest)
            .sink(receiveCompletion: { error in
                switch error {
                case .finished:
                    break
                case .failure(let error):
                    callBack(.failure(error))
                }
            }, receiveValue: { response in
                callBack(.success(response))
            }).store(in: token)
    }
}
