//
//  BookItem+Mapper.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

internal extension Book {
    func asBook() -> BookItem {
        BookItem(id: id,
                 title: volumeInfo?.title,
                 authors: volumeInfo?.authors,
                 description: volumeInfo?.description,
                 thumbnail: volumeInfo?.imageLinks?.thumbnail ?? "",
                 buyLink: saleInfo?.buyLink)
    }
}

public extension Sequence where Element == Book {
    
    func asBookArray() -> [BookItem] {
        self.map { $0.asBook() }
    }
    
}
