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

class BookDetailViewModel: ObservableObject {
    @Published var bookDetail: [BookDetail]?
    
    var router: BookDetailRouter?
    private var bookId: String?
    
    struct BookDetail: Hashable {
        let title: String?
        let value: String
    }
    
    init(_ bookItem: BookItem?) {
        bookId = bookItem?.id
        self.bookDetail = parseBook(bookItem)
    }
    
}

extension BookDetailViewModel {    
    public func send(action: ViewModel.BookDetail.ViewInput.Action) {
        switch action {
        case .dismiss:
            router?.perform(action: .dismiss)
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
            }
        }
        
        public enum ViewInput: Hashable {
            public enum Action: Hashable {
                case dismiss
            }
        }
    }
}
