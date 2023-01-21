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
import BaseUI
import DataModule

class MainViewModel: ObservableObject {
    @Published var books: [Item]?
    @Published var fetchStatus: FetchStatus = .isFetching
    
    private var pageIndex = 0
    
    enum FetchStatus {
        case isFetching
        case fetched
    }
    
    struct Item: Hashable {
        public let id: String
        public let title: String?
        public let authors: [String]?
        public let description: String?
        public let thumbnail: String
        public let buyLink: String?
    }
    
    var router: MainRouter?
    
    init(_ books: [Item]? = nil) {
        self.books = books
    }
    
    public func send(action: ViewModel.Main.ViewInput.Action) {
        switch action {
        case .dismiss:
            router?.perform(action: .dismiss)
        case .fetchBooks(let page):
            
            fetchStatus = .isFetching
            
            BookstoreDataSource.shared.booksFetch(page) {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let bookStore):
                    if self.books?.isEmpty ?? true {
                        self.books = self.parse(bookStore.items)
                    } else {
                        self.books?.append(contentsOf: self.parse(bookStore.items) ?? [])
                    }
                    self.fetchStatus = .fetched
                case .failure(let failure):
                    print(failure)
                    self.fetchStatus = .fetched
                }
            }
        case .callNextPage(let id):
            if books?.last?.id == id {
                pageIndex += 1
                
                send(action: .fetchBooks(pageIndex))
            }
        }
    }
    
    private func parse(_ books: [Book]?) -> [Item]? {
        books?.map({
            Item(id: $0.id,
                 title: $0.volumeInfo?.title,
                 authors: $0.volumeInfo?.authors,
                 description: $0.volumeInfo?.description,
                 thumbnail: $0.volumeInfo?.imageLinks?.thumbnail ?? "",
                 buyLink: $0.saleInfo?.buyLink)
        })
    }
}

public extension ViewModel {
    enum Main {
        public enum ViewOutput {
            public enum Action: Hashable {
                case dismiss
                case callNextPage(id: String)
            }
        }
        
        public enum ViewInput: Hashable {
            public enum Action: Hashable {
                case dismiss
                case fetchBooks(_ page: Int)
                case callNextPage(id: String)
            }
        }
    }
}
