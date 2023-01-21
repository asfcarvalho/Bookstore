//
//  MainViewControllerViewController.swift
//  BookStore_Anderson
//
//  Created by Anderson F Carvalho on 20/01/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import DataModule

class MainViewController: UIHostingController<MainView> {
    
    private var token = CancelBag()
    private var viewModel: MainViewModel?
    
    override init(rootView: MainView) {
        super.init(rootView: rootView)
        
        viewModel = rootView.input
        configureComunication()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel?.send(action: .fetchBooks(0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureComunication() {
        rootView.output.value.sink { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .dismiss:
                self.viewModel?.send(action: .dismiss)
            case .callNextPage(let id):
                self.viewModel?.send(action: .callNextPage(id: id))
            }
        }.store(in: token)
    }
}
