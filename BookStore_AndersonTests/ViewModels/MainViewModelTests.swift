//
//  MainViewModelTests.swift
//  BookStore_AndersonTests
//
//  Created by Anderson F Carvalho on 18/08/23.
//

import XCTest
import Common
import DataModule
@testable import BookStore_Anderson

final class MainViewModelTests: XCTestCase {
    
    var dataSource: MockBookStoreFetch!
    var sut: MainViewModel!
    var bookList: [BookItem]?

    override func setUpWithError() throws {
        dataSource = MockBookStoreFetch()
        sut = MainViewModel(bookStoreDataSource: dataSource)
        bookList = [BookItem(id: "1", title: "iOS App Development For Dummies", authors: ["Jesse Feiler"], description: "If you’ve got incredible iOS ideas, get this book and bring them to life! iOS 7 represents the most significant update to Apple’s mobile operating system since the first iPhone was released, and even the most seasoned app developers are looking for information on how to take advantage of the latest iOS 7 features in their app designs. That’s where iOS App Development For Dummies comes in! Whether you’re a programming hobbyist wanting to build an app for fun or a professional developer looking to expand into the iOS market, this book will walk you through the fundamentals of building a universal app that stands out in the iOS crowd. Walks you through joining Apple’s developer program, downloading the latest SDK, and working with Apple’s developer tools Explains the key differences between iPad and iPhone apps and how to use each device’s features to your advantage Shows you how to design your app with the end user in mind and create a fantastic user experience Covers using nib files, views, view controllers, interface objects, gesture recognizers, and much more There’s no time like now to tap into the power of iOS – start building the next big app today with help from iOS App Development For Dummies!", thumbnail: "http://books.google.com/books/content?id=q9MsAwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api", buyLink: "https://play.google.com/store/books/details?id=uXdMAQAAQBAJ&rdid=book-uXdMAQAAQBAJ&rdot=1&source=gbs_api")]
    }

    override func tearDownWithError() throws {
        dataSource = nil
        sut = nil
    }
    
    func testMainViewModel_WhenMainViewOnAppear_ThenResponseSuccess() {
        // Arrange
        let expectation = expectation(description: "Expected the fetchBooks() method to be called")
        dataSource.expectation = expectation
        dataSource.bookList = bookList
        
        // Act
        sut.send(action: .onAppear)
        
        // Assert
        self.wait(for: [expectation], timeout: 2)
        XCTAssertNotNil(dataSource.bookList)
    }
    
    func testMainViewModel_WhenMainViewOnAppear_ThenResponseFalure() {
        // Arrange
        let expectation = expectation(description: "Expected the fetchBooks() method to be called")
        dataSource.expectation = expectation
        dataSource.error = .ErrorDataEmpty
        
        // Act
        sut.send(action: .onAppear)
        
        // Assert
        self.wait(for: [expectation], timeout: 2)
        XCTAssertNil(dataSource.bookList)
        XCTAssertNotNil(dataSource.error)
    }
}
