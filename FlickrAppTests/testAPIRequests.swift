//
//  testAPIRequests.swift
//  FlickrAppTests
//
//  Created by Mahendra Yadav on 03/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import XCTest
@testable import FlickrApp

class testAPIRequests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFlickrAPIRequests(){
        let params: [String: String] = ["safe_search": "1",
                                            "page": "1" ,
                                            "text": "kitten" ,
                                            "api_key": "3e7cc266ae2b0e0d78e279ce8e361736",
                                            "nojsoncallback":"1",
                                            "per_page": "100",
                                            "method":"flickr.photos.search"]
        
        
        
        let apiRequest = FlickrAPIRequests()
        let request = try? apiRequest.makeRequest(from: params)
        
        
        if let urlString = request?.url?.absoluteString{
            XCTAssertFalse(urlString == "")
        }else{
            XCTFail("Invalid Request")
        }
        
        
    }
}
