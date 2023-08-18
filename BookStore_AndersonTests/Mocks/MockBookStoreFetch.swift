//
//  MockBookStoreFetch.swift
//  BookStore_AndersonTests
//
//  Created by Anderson F Carvalho on 18/08/23.
//

import Foundation
import DataModule
import XCTest

class MockBookStoreFetch: BookStoreFetchProtocol {
   
    var bookList: [BookItem]?
    var error: BookError?
    var expectation: XCTestExpectation?
    
    func booksFetch(_ page: Int, callBack: @escaping (Result<[BookItem], BookError>) -> Void) {
        if let bookList = bookList {
            callBack(.success(bookList))
        } else if let error = error {
            callBack(.failure(error))
        } else {
            callBack(.failure(.ErrorDefault))
        }
        
        expectation?.fulfill()
    }
}
