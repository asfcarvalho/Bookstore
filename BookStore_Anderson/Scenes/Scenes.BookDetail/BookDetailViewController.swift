//
//  BookDetailViewControllerViewController.swift
//  BookStore_Anderson
//
//  Created by Anderson F Carvalho on 21/01/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import DataModule

class BookDetailViewController: UIHostingController<BookDetailView> {
    
    private var token = CancelBag()
    private var viewModel: BookDetailViewModel?
    
    override init(rootView: BookDetailView) {
        super.init(rootView: rootView)
        
        viewModel = rootView.input
        configureComunication()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.send(action: .isFavorite)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentingViewController?.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(true)
    }
    
    func configureComunication() {
        rootView.output.value.sink { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .dismiss:
                self.viewModel?.send(action: .dismiss)
            case .favoriteTapped:
                self.viewModel?.send(action: .favoriteTapped)
            }
        }.store(in: token)
    }
}
