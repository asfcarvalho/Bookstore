//
//  Object+Creation.swift
//  LocalDatabase
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation
import RealmSwift

internal extension Object {
    static func create<T: Object>(_ builder: (T) -> Void) -> T {
        let object = T()
        builder(object)
        return object
    }
}

internal extension EmbeddedObject {
    static func create<T: EmbeddedObject>(_ builder: (T) -> Void) -> T {
        let object = T()
        builder(object)
        return object
    }
}
