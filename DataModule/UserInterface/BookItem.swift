//
//  BookItem.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

public struct BookItem: Hashable {
    public let id: String
    public let title: String?
    public let authors: [String]?
    public let description: String?
    public let thumbnail: String
    public let buyLink: String?
    
    public init(id: String, title: String?, authors: [String]?, description: String?, thumbnail: String, buyLink: String?) {
        self.id = id
        self.title = title
        self.authors = authors
        self.description = description
        self.thumbnail = thumbnail
        self.buyLink = buyLink
    }
}
