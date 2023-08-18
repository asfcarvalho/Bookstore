//
//  MainViewModelTests.swift
//  BookStore_AndersonTests
//
//  Created by Anderson F Carvalho on 18/08/23.
//

import XCTest
@testable import BookStore_Anderson

final class MainViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMainViewModel_WhenMainViewOnAppear_ThenResponseSuccess() {
        // Arrange
        let expectation = expectation(description: "Expected the fetchBooks() method to be called")
        let dataSource = MockBookStoreFetch()
        let sut = MainViewModel(bookStoreDataSource: dataSource)
        dataSource.expectation = expectation
        dataSource.movieList = LoadJsonData.loadJson(filename: "bookList")
        
        // Act
        sut.send(action: .onAppear)
        
        // Assert
        self.wait(for: [expectation], timeout: 2)
        XCTAssertNotNil(dataSource.bookList)
    }
}
