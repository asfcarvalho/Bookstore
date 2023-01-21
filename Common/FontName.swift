//
//  FontName.swift
//  Common
//
//  Created by Anderson F Carvalho on 20/01/23.
//

import Foundation
import SwiftUI

public enum MyFont {
    case systenMedium13
    case systenMedium14
    case systemMedium16
    case systemMedium22
    case systemBold16
    case systemBold22
    
    public var font: Font {
        switch self {
        case .systenMedium13:
            return Font.system(size: 13, weight: .medium)
        case .systenMedium14:
            return Font.system(size: 14, weight: .medium)
        case .systemMedium16:
            return Font.system(size: 16, weight: .medium)
        case .systemMedium22:
            return Font.system(size: 22, weight: .medium)
        case .systemBold16:
            return Font.system(size: 16, weight: .bold)
        case .systemBold22:
            return Font.system(size: 22, weight: .bold)
        }
    }
}
