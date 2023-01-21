//
//  VolumeInfo.swift
//  DataModule
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

// MARK: - VolumeInfo
public struct VolumeInfo: Codable, Hashable {
    public let title: String?
    public let authors: [String]?
    public let description: String?
    public let subtitle: String?
    public let imageLinks: ImageLinks?
}
