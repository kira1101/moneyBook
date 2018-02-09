//
//  moneyBookUITests.swift
//  moneyBookUITests
//
//  Created by p14822 on 2017/12/27.
//  Copyright © 2017年 p14822. All rights reserved.
//

import XCTest
@testable import moneyBook
import RealmSwift

class moneyBookUITests: XCTestCase {
    
    var app:XCUIApplication!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        
//        let storyboard = UIStoryboard (name: "Main" , bundle: Bundle.main)
//        vc = storyboard.instantiateInitialViewController() as! BookViewController
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        app.textFields["Amount"].tap()
        app.textFields["Amount"].typeText("123")
        app.textFields["Item"].tap()
        app.textFields["Item"].typeText("肯德基")
        app.textFields["Type"].tap()
        app.textFields["Type"].typeText("dinner")
        app.tap()
        app.buttons["add"].tap()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testEnterText()  {

        
        let app = XCUIApplication()
        let amountTextField = app.textFields["Amount"]
        amountTextField.tap()
        app.textFields["Amount"].typeText("45")
        
        app.tap()
        app.buttons["add"].tap()

    }
    
    func testAmountIsEmpty(){
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.buttons["add"]/*[[".buttons[\"新增\"]",".buttons[\"add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["警告"].buttons["確認"].tap()

        
    }

    
}
