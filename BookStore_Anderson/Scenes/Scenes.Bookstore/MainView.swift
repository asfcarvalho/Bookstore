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
    var imageWidth = (UIScreen.screenWidth / 2) - 32
    var imageHeight = (UIScreen.screenWidth * 0.7) - 32
    @State var isFiltering: Bool = true
    
    init(input: MainViewModel) {
        self.input = input
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Spacer()
                Button {
                    output.value.send(.filterTapped)
                } label: {
                    Text("Show favorites")
                        .font(.title3.bold())
                    Image(systemName: input.filterButton)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25)
                }.foregroundColor(Color.black)
            }.padding()
            ScrollView {
                VStack {
                    if !input.booksFiltered.isEmpty {
                        LazyVGrid(columns: [GridItem(.fixed(imageWidth), spacing: 16),
                                            GridItem(.fixed(imageWidth), spacing: 16)]) {
                            ForEach(input.booksFiltered.indices, id: \.self) { index in
                                HStack {
                                    setItem(input.booksFiltered[index].thumbnail)
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
            url: URL(string: url)) { phase in
                if let image = phase.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageWidth, height: imageHeight)
                } else if let error = phase.error {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay {
                            Image(systemName: "photo.artframe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: imageWidth / 2)
                                .foregroundColor(Color.gray)
                        }
                    let _ = debugPrint(error)
                } else {
                    ProgressView()
                }
            }
        
        .frame(width: imageWidth, height: imageHeight)
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
