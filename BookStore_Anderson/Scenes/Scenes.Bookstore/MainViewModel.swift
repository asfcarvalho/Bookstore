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

class MainViewModel: ObservableObject {
    @Published var booksFiltered: [BookItem] = []
    @Published var fetchStatus: FetchStatus = .isFetching
        
    private var pageIndex = 0
    private var booksFavorite: [String] = []
    private var books: [BookItem] = []
    private var bookStoreDataSource: BookStoreFetchProtocol!
    
    enum FetchStatus {
        case isFetching
        case fetched
    }
    
    var router: MainRouter?
    
    init(_ books: [BookItem] = [],
         bookStoreDataSource: BookStoreFetchProtocol = BookStoreFetch()) {
        self.booksFiltered = books
        self.bookStoreDataSource = bookStoreDataSource
    }
    
}

extension MainViewModel {
    
    public func send(action: ViewModel.Main.ViewInput.Action) {
        switch action {
        case .onAppear:
            send(action: .fetchBooks(pageIndex))
            
        case .onReload:
            break
            
        case .dismiss:
            router?.perform(action: .dismiss)
        case .fetchBooks(let page):
            
            fetchStatus = .isFetching
            fetchBook(page)

        case .callNextPage:
            pageIndex += 1
            
            send(action: .fetchBooks(pageIndex))
            
        case .showDetail(let index):
            let book = booksFiltered[index]
            router?.perform(action: .showDetail(book))
        }
    }
    
    private func fetchBook(_ page: Int) {
        bookStoreDataSource.booksFetch(page) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let bookStore):
                DispatchQueue.main.async {
                    if self.books.isEmpty {
                        self.books = bookStore
                    } else {
                        self.books.append(contentsOf: bookStore)
                    }
                    self.booksFiltered = self.books
                    self.fetchStatus = .fetched
                }
            case .failure(let failure):
                print(failure)
                DispatchQueue.main.async {
                    self.fetchStatus = .fetched
                }
            }
        }
    }
    
    private func getUniqueBooks(_ filtered: [BookItem]) -> [BookItem] {
        var unique: [String: String] = [:]
        var bookUnique: [BookItem] = []
        
        filtered.forEach({
            if unique[$0.id]?.isEmpty ?? true {
                unique[$0.id] = $0.id
                bookUnique.append($0)
            }
        })
        
        return bookUnique
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
            }
        }
    }
}
