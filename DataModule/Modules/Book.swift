//
//  Book.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

public struct Book: Codable, Hashable {
    public let id: String
    public let volumeInfo: VolumeInfo?
    public let saleInfo: SaleInfo?
}
