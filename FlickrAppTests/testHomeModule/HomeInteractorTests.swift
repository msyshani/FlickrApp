//
//  HomeInteractorTests.swift
//  FlickrAppTests
//
//  Created by Mahendra Yadav on 04/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import XCTest
@testable import FlickrApp

class HomeInteractorTests: NetworkBaseTest , JSONMockable{
    var interator: HomePresenterToInteractorProtocol?
    var interactorOurput = HomeInteractiorOutputTest()
    
    //var dicExpectation: XCTestExpectation!
    private var dicExpectation: XCTestExpectation!
    
    class HomeInteractiorOutputTest: HomeInteractorToPresenterProtocol {
        var imageArray = [FlickrPhoto]()
        var error: FlickrServiceError?
        
        var dicExpectation: XCTestExpectation!
        var failExpectation: XCTestExpectation!
        func imageFetchingRequestCompletedSuccessfully(model: PhotoSearchResult) {
            imageArray = model.photos
            if let exp = dicExpectation{
                exp.fulfill()
            }

        }
        
        func imgaeFetchingRequestFailed(withError error: Error) {
            self.error = error as? FlickrServiceError
            if let exp = failExpectation{
                exp.fulfill()
            }
            
        }
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        interator = HomeInteractor(with: APIRequestLoader(apiRequest: FlickrAPIRequests()))
        interator?.presenter = interactorOurput
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchImageFromService(){
        dicExpectation = expectation(description: "fetchingImage")
        interactorOurput.dicExpectation = dicExpectation
        interator?.searchImageFromService(withText: "hello", page: 1, pageCount: 100)
        waitForExpectations(timeout: 50, handler: nil)
    }

    func testSearchImageFromServiceForFailure(){
        dicExpectation = expectation(description: "fetchingImageFalure")
        interactorOurput.failExpectation = dicExpectation
        interator?.searchImageFromService(withText: "::::>:::::::", page: 1, pageCount: 100)
        waitForExpectations(timeout: 50, handler: nil)
    }
   

}
