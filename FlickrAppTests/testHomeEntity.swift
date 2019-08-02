//
//  testHomeEntity.swift
//  FlickrAppTests
//
//  Created by Mahendra Yadav on 02/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import XCTest
import Foundation
@testable import FlickrApp

class testHomeEntity: XCTestCase {

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
    
    func testPhotoModel(){
        if let data = getDemoJson().data(using: .utf8){
            let person = try! JSONDecoder().decode(FlickrPhoto.self, from: data)
            XCTAssertEqual(person.id, "23451156376")
            XCTAssertEqual(person.secret, "8983a8ebc7")
            XCTAssertEqual(person.server, "578")
            XCTAssertEqual(person.title, "Merry Christmas!")
            XCTAssertEqual(person.farm, 1)
        }else{
            XCTFail("Invalid Json")
        }
        
    }
    
    func getDemoJson()->String{
        let josnString = """
                              {
                                "id": "23451156376",
                                "owner": "28017113@N08",
                                "secret": "8983a8ebc7",
                                "server": "578",
                                "farm": 1,
                                "title": "Merry Christmas!",
                                "ispublic": 1,
                                "isfriend": 0,
                                "isfamily": 0
                              }
                         """
        return josnString
    }

}
