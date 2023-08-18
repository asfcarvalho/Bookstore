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
            ScrollView {
                VStack {
                    if !input.booksFiltered.isEmpty {
                        LazyVGrid(columns: [GridItem(.fixed(imageWidth), spacing: 16),
                                            GridItem(.fixed(imageWidth), spacing: 16)]) {
                            ForEach(input.booksFiltered.indices, id: \.self) { index in
                                Button {
                                    output.value.send(.showDetail(index: index))
                                } label: {
                                    setItem(input.booksFiltered[index].thumbnail)
                                }
                                .onAppear {
                                    output.value.send(.callNextPage(index: index))
                                }.accessibilityIdentifier("bookItem_\(input.booksFiltered[index].id)")
                            }
                        }.accessibilityIdentifier("bookListView")
                        if input.fetchStatus == .isFetching {
                            ProgressView()
                                .padding(.vertical)
                        }
                    } else if input.fetchStatus == .isFetching {
                        ProgressView()
                    } else {
                        Text("No Books found")
                            .accessibilityIdentifier("bookListEmpty")
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
        MainView(input: .init([BookItem(id: "1", title: "iOS App Development For Dummies", authors: ["Jesse Feiler"], description: "If you’ve got incredible iOS ideas, get this book and bring them to life! iOS 7 represents the most significant update to Apple’s mobile operating system since the first iPhone was released, and even the most seasoned app developers are looking for information on how to take advantage of the latest iOS 7 features in their app designs. That’s where iOS App Development For Dummies comes in! Whether you’re a programming hobbyist wanting to build an app for fun or a professional developer looking to expand into the iOS market, this book will walk you through the fundamentals of building a universal app that stands out in the iOS crowd. Walks you through joining Apple’s developer program, downloading the latest SDK, and working with Apple’s developer tools Explains the key differences between iPad and iPhone apps and how to use each device’s features to your advantage Shows you how to design your app with the end user in mind and create a fantastic user experience Covers using nib files, views, view controllers, interface objects, gesture recognizers, and much more There’s no time like now to tap into the power of iOS – start building the next big app today with help from iOS App Development For Dummies!", thumbnail: "http://books.google.com/books/content?id=q9MsAwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", buyLink: "https://play.google.com/store/books/details?id=uXdMAQAAQBAJ&rdid=book-uXdMAQAAQBAJ&rdot=1&source=gbs_api"),
                               BookItem(id: "1", title: "iOS App Development For Dummies", authors: ["Jesse Feiler"], description: "If you’ve got incredible iOS ideas, get this book and bring them to life! iOS 7 represents the most significant update to Apple’s mobile operating system since the first iPhone was released, and even the most seasoned app developers are looking for information on how to take advantage of the latest iOS 7 features in their app designs. That’s where iOS App Development For Dummies comes in! Whether you’re a programming hobbyist wanting to build an app for fun or a professional developer looking to expand into the iOS market, this book will walk you through the fundamentals of building a universal app that stands out in the iOS crowd. Walks you through joining Apple’s developer program, downloading the latest SDK, and working with Apple’s developer tools Explains the key differences between iPad and iPhone apps and how to use each device’s features to your advantage Shows you how to design your app with the end user in mind and create a fantastic user experience Covers using nib files, views, view controllers, interface objects, gesture recognizers, and much more There’s no time like now to tap into the power of iOS – start building the next big app today with help from iOS App Development For Dummies!", thumbnail: "http://books.google.com/books/content?id=q9MsAwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", buyLink: "https://play.google.com/store/books/details?id=uXdMAQAAQBAJ&rdid=book-uXdMAQAAQBAJ&rdot=1&source=gbs_api"),
                               BookItem(id: "1", title: "iOS App Development For Dummies", authors: ["Jesse Feiler"], description: "If you’ve got incredible iOS ideas, get this book and bring them to life! iOS 7 represents the most significant update to Apple’s mobile operating system since the first iPhone was released, and even the most seasoned app developers are looking for information on how to take advantage of the latest iOS 7 features in their app designs. That’s where iOS App Development For Dummies comes in! Whether you’re a programming hobbyist wanting to build an app for fun or a professional developer looking to expand into the iOS market, this book will walk you through the fundamentals of building a universal app that stands out in the iOS crowd. Walks you through joining Apple’s developer program, downloading the latest SDK, and working with Apple’s developer tools Explains the key differences between iPad and iPhone apps and how to use each device’s features to your advantage Shows you how to design your app with the end user in mind and create a fantastic user experience Covers using nib files, views, view controllers, interface objects, gesture recognizers, and much more There’s no time like now to tap into the power of iOS – start building the next big app today with help from iOS App Development For Dummies!", thumbnail: "http://books.google.com/books/content?id=q9MsAwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", buyLink: "https://play.google.com/store/books/details?id=uXdMAQAAQBAJ&rdid=book-uXdMAQAAQBAJ&rdot=1&source=gbs_api")]))
    }
}
#endif
