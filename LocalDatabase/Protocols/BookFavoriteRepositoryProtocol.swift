//
//  BookFavoriteRepositoryProtocol.swift
//  LocalDatabase
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

public protocol BookFavoriteRepositoryProtocol {
    func saveFavorite(_ id: String, completionBlock: (Result<Void, Error>) -> Void)
    func removeFavorite(_ id: String, completionBlock: (Result<Void, Error>) -> Void)
    func getIsFavorite(_ id: String, completionBlock: (Result<Bool, Error>) -> Void)
    func getAllFavorite(completionBlock: (Result<[String], Error>) -> Void)
}
