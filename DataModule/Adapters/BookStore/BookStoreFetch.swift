//
//  BookStoreFetch.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 10/02/23.
//

import Foundation

public class BookStoreFetch: BookStoreFetchProtocol {
    
    public init() { }
    
    public func booksFetch(_ page: Int, callBack: @escaping (Result<[BookItem], Error>) -> Void) {
        BookstoreDataSource.shared.booksFetch(page) { result in
            switch result {
            case .success(let bookStore):
                callBack(.success(bookStore.items?.asBookArray() ?? []))
            case .failure(let failure):
                callBack(.failure(failure))
            }
        }
    }
}
