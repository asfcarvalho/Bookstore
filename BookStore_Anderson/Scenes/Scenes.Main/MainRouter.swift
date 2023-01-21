//
//  MainRouterRouter.swift
//  BookStore_Anderson
//
//  Created by Anderson F Carvalho on 20/01/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import BaseUI

class MainRouter{
    
    private(set) weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
        
    class func build() -> UIHostingController<MainView> {
        let viewModel = MainViewModel()
        let rootView = MainView(input: viewModel)
        let viewController = MainViewController(rootView: rootView)
        viewModel.router = MainRouter(viewController: viewController)
        
        return viewController
    }
    
    func perform(action: Router.MainRouter.ViewOutput.Acion) {
        switch action {
        case .sample:
            break
        case .dismiss:
            viewController?.dismiss(animated: true)
        }
    }
}

public extension Router {
    enum MainRouter {
        public enum ViewOutput {
            public enum Acion: Hashable {
                case sample
                case dismiss
            }
        }
    }
}
