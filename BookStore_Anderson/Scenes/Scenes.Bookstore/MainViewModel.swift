//
//  MainViewModelViewModel.swift
//  BookStore_Anderson
//
//  Created by Anderson F Carvalho on 20/01/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import DataModule
import Common
import BaseUI
import LocalDatabase

class MainViewModel: ObservableObject {
    @Published var booksFiltered: [BookItem] = []
    @Published var fetchStatus: FetchStatus = .isFetching
    @Published var isFiltering: Bool = false
    
    private var pageIndex = 0
    private var booksFavorite: [String] = []
    private var books: [BookItem] = []
    private var favoriteStorage: BookFavoriteRepositoryProtocol!
    
    enum FetchStatus {
        case isFetching
        case fetched
    }
    
    var router: MainRouter?
    
    init(_ books: [BookItem] = []) {
        self.booksFiltered = books
        favoriteStorage = BookFavoriteStorageRepository()
        configureComunication()
    }
    
}

extension MainViewModel {
    
    public func send(action: ViewModel.Main.ViewInput.Action) {
        switch action {
        case .onAppear:
            send(action: .fetchBooks(pageIndex))
            
        case .onReload:
            send(action: .fetchFavorites)
            
        case .fetchFavorites:
            fetchFavorites()
            self.isFiltering = isFiltering
            
        case .dismiss:
            router?.perform(action: .dismiss)
        case .fetchBooks(let page):
            
            fetchStatus = .isFetching
            fetchBook(page)

        case .callNextPage(let index):
            if !isFiltering && booksFiltered.count - 3 == index {
                pageIndex += 1
                
                send(action: .fetchBooks(pageIndex))
            }
            
        case .showDetail(let index):
            let book = booksFiltered[index]
            router?.perform(action: .showDetail(book))
        }
    }
    
    private func fetchBook(_ page: Int) {
        BookstoreDataSource.shared.booksFetch(page) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let bookStore):
                if self.books.isEmpty {
                    self.books = bookStore.items?.asBookArray() ?? []
                } else {
                    self.books.append(contentsOf: bookStore.items?.asBookArray() ?? [])
                }
                self.booksFiltered = self.books
                self.fetchStatus = .fetched
            case .failure(let failure):
                print(failure)
                self.fetchStatus = .fetched
            }
        }
    }
    
    private func fetchFavorites() {
        favoriteStorage.getAllFavorite { result in
            switch result {
            case .success(let favorites):
                self.booksFavorite = favorites
            case .failure(let failure):
                debugPrint(failure)
            }
        }
    }
    
    private func configureComunication() {
        $isFiltering
            .map({ isFiltering in
                if isFiltering {
                    return Array(Set(self.books.filter({
                        self.booksFavorite.contains($0.id)
                    })))
                } else {
                    return self.books
                }
            })
            .assign(to: &$booksFiltered)
    }
}

public extension ViewModel {
    enum Main {
        public enum ViewOutput {
            public enum Action: Hashable {
                case dismiss
                case callNextPage(index: Int)
                case showDetail(index: Int)
            }
        }
        
        public enum ViewInput: Hashable {
            public enum Action: Hashable {
                case dismiss
                case fetchBooks(_ page: Int)
                case callNextPage(index: Int)
                case showDetail(index: Int)
                case onAppear
                case onReload
                case fetchFavorites
            }
        }
    }
}
