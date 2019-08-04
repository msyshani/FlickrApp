//
//  FlickrAppUITests.swift
//  FlickrAppUITests
//
//  Created by Mahendra Yadav on 02/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import XCTest

class FlickrAppUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAllcase(){
        testImageSearchSuccuss()
        testImageSearchFail()
        testCancelButton()
    }
    

    func testImageSearchSuccuss(){
        let placeholderSearchSearchField = app.navigationBars["FlickrApp.HomeView"].searchFields["placeholder_search"]
        placeholderSearchSearchField.tap()
        placeholderSearchSearchField.typeText("dog")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: collectionViewsQuery.firstMatch, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        XCTAssertTrue(collectionViewsQuery.cells.count > 0)
    }
    
    func testImageSearchFail(){
        let placeholderSearchSearchField = XCUIApplication().navigationBars["FlickrApp.HomeView"].searchFields["placeholder_search"]
        placeholderSearchSearchField.tap()
        let clearTextButton = placeholderSearchSearchField.buttons["Clear text"]
        if clearTextButton.exists{
            clearTextButton.tap()
        }
        
        placeholderSearchSearchField.typeText("dog")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: collectionViewsQuery.firstMatch, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssertFalse(collectionViewsQuery.cells.count == 0)
        
    }
    
    func testCancelButton(){
        let placeholderSearchSearchField = XCUIApplication().navigationBars["FlickrApp.HomeView"].searchFields["placeholder_search"]
        placeholderSearchSearchField.tap()
        let clearTextButton = placeholderSearchSearchField.buttons["Clear text"]
        if clearTextButton.exists{
            clearTextButton.tap()
        }
        placeholderSearchSearchField.typeText("dog")
        
        if let text = placeholderSearchSearchField.value as? String, text == "dog"{}else{
            XCTFail("search not workng")
        }
        clearTextButton.tap()
        if let text = placeholderSearchSearchField.value as? String {
            XCTAssertTrue(text == "placeholder_search", "Clear button not working")
        }else{
            XCTFail("search not workng")
        }
    }

}
