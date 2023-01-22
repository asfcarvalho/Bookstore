//
//  BookDetailViewView.swift
//  BookStore_Anderson
//
//  Created by Anderson F Carvalho on 21/01/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Common
import Components
import DataModule
import BaseUI

struct BookDetailView: View {
    
    @ObservedObject var input: BookDetailViewModel
    public var output = MyObservableObject<ViewModel.BookDetail.ViewOutput.Action>()
    
    private var token = CancelBag()
    
    init(input: BookDetailViewModel) {
        self.input = input
    }
    
    var body: some View {
        VStack {
            navigationBar
            VStack(spacing: 8) {
                Toggle(isOn: $input.isFavorite) {
                    Text("Save to Favorite")
                        .font(.title2.bold())
                }.padding(.horizontal)
                    .onChange(of: input.isFavorite) { newValue in
                        output.value.send(.favoriteTapped)
                    }
                Divider()
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        if let bookDetail = input.bookDetail {
                            ForEach(bookDetail, id: \.self) { detail in
                                setItem(detail.title, detail.value)
                            }
                        }
                    }.padding(.horizontal)
                        .frame(width: UIScreen.screenWidth, alignment: .leading)
                }
            }.padding(.top)
        }.navigationBarHidden(true)
    }
    
    private func setItem(_ title: String?, _ value: String) -> some View {
        VStack(alignment: .leading) {
            if let title = title {
                Text(title)
                    .font(.title2.bold())
            }
            Text(.init(value))
        }
    }
    
    private var navigationBar: some View {
        let navigation = MyNavigationBarView(input: .init(title: "Book"))
        
        navigation.output.value.sink { action in
            switch action {
            case .buttonLeftTapped:
                output.value.send(.dismiss)
            default:
                break
            }
        }.store(in: token)
        
        return navigation
    }
}

//
// MARK: - Previews
//
#if canImport(SwiftUI) && DEBUG
struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(input: .init(BookItem(id: "222", title: "iOS Hacker's Handbook", authors: [
            "Charlie Miller",
            "Dion Blazakis",
            "Dino DaiZovi",
            "Stefan Esser",
            "Vincenzo Iozzo",
            "Ralf-Philip Weinmann"
        ],
                                             description: "If you’ve got incredible iOS ideas, get this book and bring them to life! iOS 7 represents the most significant update to Apple’s mobile operating system since the first iPhone was released, and even the most seasoned app developers are looking for information on how to take advantage of the latest iOS 7 features in their app designs. That’s where iOS App Development For Dummies comes in! Whether you’re a programming hobbyist wanting to build an app for fun or a professional developer looking to expand into the iOS market, this book will walk you through the fundamentals of building a universal app that stands out in the iOS crowd. Walks you through joining Apple’s developer program, downloading the latest SDK, and working with Apple’s developer tools Explains the key differences between iPad and iPhone apps and how to use each device’s features to your advantage Shows you how to design your app with the end user in mind and create a fantastic user experience Covers using nib files, views, view controllers, interface objects, gesture recognizers, and much more There’s no time like now to tap into the power of iOS – start building the next big app today with help from iOS App Development For Dummies!",
                                             thumbnail: "http://books.google.com/books/content?id=1kDcjKcz9GwC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
                                             buyLink: "https://play.google.com/store/books/details?id=1kDcjKcz9GwC&rdid=book-1kDcjKcz9GwC&rdot=1&source=gbs_api")))
    }
}
#endif
