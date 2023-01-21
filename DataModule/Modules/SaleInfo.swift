//
//  SaleInfo.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

// MARK: - SaleInfo
public struct SaleInfo: Codable, Hashable {
    public let isEbook: Bool?
    public let buyLink: String?
}
