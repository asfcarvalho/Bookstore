//
//  Favorite+Transform.swift
//  LocalDatabase
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

internal extension BookFavoriteRLM {
    func asFavorite() -> String {
        favoriteId
    }
}

internal extension Sequence where Element == BookFavoriteRLM {
    
    func asFavoriteArray() -> [String] {
        self.map { $0.asFavorite() }
    }
    
}

internal extension String {
    func asFavoriteRLM() -> BookFavoriteRLM {
        BookFavoriteRLM.create { favorite in
            favorite.favoriteId = self
        }
    }
}
