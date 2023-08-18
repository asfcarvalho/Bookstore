//
//  BookStore_AndersonUITests.swift
//  BookStore_AndersonUITests
//
//  Created by Anderson F Carvalho on 20/01/23.
//

import XCTest

final class BookStore_AndersonUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        app = XCUIApplication()
        app.launchArguments = ["UI-TESTING"]

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testBookMainView_WhenViewLoad_ThenDisplayBookList() throws {
        // Arrange
        app.launchEnvironment["JSON-URL"] = "bookList"
        let list = app.scrollViews.otherElements.otherElements["bookListView"]
                
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(list.exists)
    }
    
    func testBookMainView_WhenViewLoad_ThenNotDisplayBookList() throws {
        // Arrange
        app.launchEnvironment["JSON-URL"] = "bookListEmpty"
        let listEmpty = app.staticTexts["bookListEmpty"]
        XCUIApplication().scrollViews.otherElements.staticTexts["0"].tap()
                                
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(listEmpty.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
