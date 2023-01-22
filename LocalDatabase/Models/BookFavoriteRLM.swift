//
//  BookFavoriteRLM.swift
//  LocalDatabase
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation
import RealmSwift

@objcMembers
internal class BookFavoriteRLM: Object {
    override class func primaryKey() -> String? {
        #keyPath(BookFavoriteRLM.favoriteId)
    }
    
    @objc internal dynamic var favoriteId: String = ""
    internal dynamic var name: String = ""
}
