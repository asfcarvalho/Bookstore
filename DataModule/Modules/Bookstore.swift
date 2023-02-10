//
//  Bookstore.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

// MARK: - Bookstore
internal struct Bookstore: Codable {
    internal let kind: String?
    internal let totalItems: Int?
    internal let items: [Book]?
}
