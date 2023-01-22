//
//  BookDetailRouterRouter.swift
//  BookStore_Anderson
//
//  Created by Anderson F Carvalho on 21/01/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import DataModule
import BaseUI

class BookDetailRouter{
    
    private(set) weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
        
    class func build(_ bookItem: BookItem?) -> UIHostingController<BookDetailView> {
        let viewModel = BookDetailViewModel(bookItem)
        let rootView = BookDetailView(input: viewModel)
        let viewController = BookDetailViewController(rootView: rootView)
        viewModel.router = BookDetailRouter(viewController: viewController)
        
        return viewController
    }
    
    func perform(action: Router.BookDetailRouter.ViewOutput.Acion) {
        switch action {
        case .sample:
            break
        case .dismiss:
            viewController?.dismiss(animated: true)
        }
    }
}

public extension Router {
    enum BookDetailRouter {
        public enum ViewOutput {
            public enum Acion: Hashable {
                case sample
                case dismiss
            }
        }
    }
}
