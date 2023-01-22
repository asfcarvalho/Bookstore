//
//  BookDetailViewModelViewModel.swift
//  BookStore_Anderson
//
//  Created by Anderson F Carvalho on 21/01/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import DataModule
import BaseUI
import LocalDatabase

class BookDetailViewModel: ObservableObject {
    @Published var bookDetail: [BookDetail]?
    @Published var isFavorite: Bool = false
    
    var router: BookDetailRouter?
    private var bookId: String?
    private var favoriteStorage: BookFavoriteRepositoryProtocol!
    
    struct BookDetail: Hashable {
        let title: String?
        let value: String
    }
    
    init(_ bookItem: BookItem?) {
        bookId = bookItem?.id
        self.bookDetail = parseBook(bookItem)
        favoriteStorage = BookFavoriteStorageRepository()
    }
    
}

extension BookDetailViewModel {    
    public func send(action: ViewModel.BookDetail.ViewInput.Action) {
        switch action {
        case .dismiss:
            router?.perform(action: .dismiss)
        case .isFavorite:
            favoriteStorage.getIsFavorite(bookId ?? "") { result in
                switch result {
                case .success(let isFavorite):
                    self.isFavorite = isFavorite
                case .failure(let failure):
                    debugPrint(failure)
                }
            }
        case .favoriteTapped:
            guard let bookId = bookId else { return }
            
            if isFavorite {
                favoriteStorage.saveFavorite(bookId) { result in
                    switch result {
                    case .success(let success):
                        debugPrint(success)
                    case .failure(let failure):
                        debugPrint(failure)
                    }
                }
            } else {
                favoriteStorage.removeFavorite(bookId) { result in
                    switch result {
                    case .success(let success):
                        debugPrint(success)
                    case .failure(let failure):
                        debugPrint(failure)
                    }
                }
            }
        }
    }
    
    private func parseBook(_ bookItem: BookItem?) -> [BookDetail] {
        var bookDetail: [BookDetail] = []
        
        if let title = bookItem?.title {
            bookDetail.append(
                BookDetail(title: "Title", value: title)
            )
        }
        
        if let author = bookItem?.authors {
            bookDetail.append(
                BookDetail(title: "Author", value: author.joined(separator: ","))
            )
        }
        
        if let description = bookItem?.description {
            bookDetail.append(
                BookDetail(title: "Description", value: description)
            )
        }
        
        if let buyLink = bookItem?.buyLink {
            bookDetail.append(
                BookDetail(title: nil, value: "[Link to Buy](\(buyLink))")
            )
        }
        
        return bookDetail
    }
}

public extension ViewModel {
    enum BookDetail {
        public enum ViewOutput {
            public enum Action: Hashable {
                case dismiss
                case favoriteTapped
            }
        }
        
        public enum ViewInput: Hashable {
            public enum Action: Hashable {
                case dismiss
                case isFavorite
                case favoriteTapped
            }
        }
    }
}
