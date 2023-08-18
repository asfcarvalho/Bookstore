//
//  BookStoreProtocol.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 10/02/23.
//

import Foundation

public protocol BookStoreFetchProtocol {
    func booksFetch(_ page: Int, callBack: @escaping (Result<[BookItem], BookError>) -> Void)
}
