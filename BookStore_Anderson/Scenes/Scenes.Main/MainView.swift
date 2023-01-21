//
//  MainViewView.swift
//  BookStore_Anderson
//
//  Created by Anderson F Carvalho on 20/01/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Common
import BaseUI
import Components
import DataModule

struct MainView: View {
    
    @ObservedObject var input: MainViewModel
    public var output = MyObservableObject<ViewModel.Main.ViewOutput.Action>()
    
    private var token = CancelBag()
    
    init(input: MainViewModel) {
        self.input = input
    }
    
    var body: some View {
        ScrollView {
            VStack {
                if let books = input.books {
                    LazyVGrid(columns: [GridItem(.fixed((UIScreen.screenWidth / 2) - 32), spacing: 16),
                                        GridItem(.fixed((UIScreen.screenWidth / 2) - 32), spacing: 16)]) {
                        ForEach(books, id: \.self) { book in
                            HStack {
                                setItem(book.thumbnail)
                            }.onAppear {
                                output.value.send(.callNextPage(id: book.id))
                            }
                        }
                    }
                    if input.fetchStatus == .isFetching {
                        ProgressView()
                            .padding(.vertical)
                    }
                } else if input.fetchStatus == .isFetching {
                    ProgressView()
                } else {
                    Text("No Books found")
                }
            }
        }.navigationBarHidden(true)
    }
    
    private func setItem(_ url: String) -> some View {
        AsyncImage(
            url: URL(string: url),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: (UIScreen.screenWidth / 2) - 32, height: (UIScreen.screenWidth * 0.7) - 32)
            },
            placeholder: {
                ProgressView()
            }).frame(width: (UIScreen.screenWidth / 2) - 32, height: (UIScreen.screenWidth * 0.7) - 32)
            .clipped()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(input: .init())
    }
}
