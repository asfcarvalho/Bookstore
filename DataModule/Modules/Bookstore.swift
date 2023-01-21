//
//  Bookstore.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

// MARK: - Bookstore
public struct Bookstore: Codable {
    public let kind: String?
    public let totalItems: Int?
    public let items: [Book]?
}
