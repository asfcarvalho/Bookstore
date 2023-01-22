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
import Components
import DataModule
import BaseUI

struct MainView: View {
    
    @ObservedObject var input: MainViewModel
    public var output = MyObservableObject<ViewModel.Main.ViewOutput.Action>()
    
    private var token = CancelBag()
    
    init(input: MainViewModel) {
        self.input = input
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Spacer()
                Text("Show favorites")
                    .font(.title2.bold())
                Toggle("", isOn: $input.isFiltering)
                    .frame(width:60)
            }.padding()
            ScrollView {
                VStack {
                    if let books = input.booksFiltered {
                        LazyVGrid(columns: [GridItem(.fixed((UIScreen.screenWidth / 2) - 32), spacing: 16),
                                            GridItem(.fixed((UIScreen.screenWidth / 2) - 32), spacing: 16)]) {
                            ForEach(books.indices, id: \.self) { index in
                                HStack {
                                    setItem(books[index].thumbnail)
                                }.onTapGesture {
                                    output.value.send(.showDetail(index: index))
                                }
                                .onAppear {
                                    output.value.send(.callNextPage(index: index))
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

//
// MARK: - Previews
//
#if canImport(SwiftUI) && DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(input: .init())
    }
}
#endif
