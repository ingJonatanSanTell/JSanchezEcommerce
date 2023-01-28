//
//  JSanchezEcommerceUITests.swift
//  JSanchezEcommerceUITests
//
//  Created by MacBookMBA4 on 17/01/23.
//

import XCTest

final class JSanchezEcommerceUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let email = app.textFields["EMAIL:"]
        XCTAssertTrue(email.exists)
        
        email.tap()
        email.typeText("yoedsate@hotmail.com")
        
        
        let password = app.secureTextFields["PASSWORD:"]
        XCTAssertTrue(password.exists)
        
        password.tap()
        password.typeText("123456")
        
        let buttonLogin = app.buttons["Login"]
        XCTAssertTrue(buttonLogin.exists)
        
        let buttonDone = app.buttons["Done"]
        XCTAssertTrue(buttonDone.exists)
        
        buttonDone.tap()
        
        buttonLogin.tap()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
