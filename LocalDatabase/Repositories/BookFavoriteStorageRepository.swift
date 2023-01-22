//
//  BookFavoriteStorageRepository.swift
//  LocalDatabase
//
//  Created by Anderson F Carvalho on 21/01/23.
//

import Foundation

public final class BookFavoriteStorageRepository: BaseStorageRepository, BookFavoriteRepositoryProtocol {
    public func saveFavorite(_ id: String, completionBlock: (Result<Void, Error>) -> Void) {
        let realm = self.realm
        
        do {
            try realm.write {
                let new = id.asFavoriteRLM()
                realm.add(new)
                completionBlock(.success(()))
            }
        } catch {
            completionBlock(.failure(error))
        }
    }
    
    public func removeFavorite(_ id: String, completionBlock: (Result<Void, Error>) -> Void) {
        let realm = self.realm
        
        do {
            try realm.write {
                let objects = realm.objects(BookFavoriteRLM.self).filter("favoriteId == %@", id)
                realm.delete(objects)
                completionBlock(.success(()))
            }
        } catch {
            completionBlock(.failure(error))
        }
    }
    
    public func getIsFavorite(_ id: String, completionBlock: (Result<Bool, Error>) -> Void) {
        let realm = self.realm
        let objects = realm.objects(BookFavoriteRLM.self).filter("favoriteId == %@", id).first
        
        completionBlock(.success(objects != nil))
    }
    
    public func getAllFavorite(completionBlock: (Result<[String], Error>) -> Void) {
        let realm = self.realm
        let objects = realm.objects(BookFavoriteRLM.self)
        
        completionBlock(.success(objects.asFavoriteArray()))
    }
}
