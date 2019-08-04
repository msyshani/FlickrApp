//
//  HomePresenterTest.swift
//  FlickrAppTests
//
//  Created by Mahendra Yadav on 04/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import XCTest
@testable import FlickrApp

class HomePresenterTest: XCTestCase {
    var interator: HomePresenterToInteractorProtocol?
    let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol  = HomePresenter()
    var view: HomePresenterToViewProtocol?
 
    
    class ViewControllerTest : HomePresenterToViewProtocol{
        var presenter: HomeViewToPresenterProtocol?
        
        func reloadTable() {
            
        }
        
        func displayError(errorMessage: String) {
            
        }
        
        func showIdealState() {
            
        }
        
        func showSearchingState() {
            
        }
        
        func showErrorState(message: String) {
            
        }
        
        
    }
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter.view = ViewControllerTest()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: - two section
    func testImageSection(){
        guard let result = testPhotoResultModel(json: getDemoJson()) else{
            XCTFail("Unable to parse model")
            return
        }
        presenter.imageFetchingRequestCompletedSuccessfully(model: result)
        
        XCTAssertTrue(presenter.imageArray.count == 1, "invalid data in array")
        XCTAssertTrue(presenter.numberOfSection() == 2, "invalid number of section")
        XCTAssertTrue(presenter.numberOfRow(inSection: 0) == 1, "invalid number of row insection")
        
        
        let imageUrl = "http://farm66.static.flickr.com/65535/48444316461_7333e18a1d.jpg"
        let presenterUrl = presenter.getImageUrl(atIndexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(presenterUrl == imageUrl, "invalid url created by presenter")
    }
    
    //MARK: - single section
    func testSingleSection(){
        guard let result = testPhotoResultModel(json: getDemoJsonForSingleSection()) else{
            XCTFail("Unable to parse model")
            return
        }
        presenter.imageFetchingRequestCompletedSuccessfully(model: result)
        
        XCTAssertTrue(presenter.imageArray.count == 1, "invalid data in array")
        XCTAssertTrue(presenter.numberOfSection() == 1, "invalid number of section")
        XCTAssertTrue(presenter.numberOfRow(inSection: 0) == 1, "invalid number of row in section")
        
        
        let imageUrl = "http://farm66.static.flickr.com/65535/48444316461_7333e18a1d.jpg"
        let presenterUrl = presenter.getImageUrl(atIndexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(presenterUrl == imageUrl, "invalid url created by presenter")
    }
    
    
    
    func testError(){
        presenter.imgaeFetchingRequestFailed(withError: FlickrServiceError.noData)
        XCTAssertTrue(presenter.imageArray.count == 0, "invalid data in array")
        XCTAssertTrue(presenter.numberOfSection() == 1, "invalid number of section")
        XCTAssertTrue(presenter.numberOfRow(inSection: 0) == 0, "invalid number of row in section")
    }
    
    
    
    
    
    
    func testPhotoResultModel(json:String)->PhotoSearchResult?{
        if let data = json.data(using: .utf8){
            let photoResult = try! JSONDecoder().decode(PhotoSearchResult.self, from: data)
            return photoResult
        }else{
            XCTFail("Invalid Json")
        }
        return nil
    }
    
    func getDemoJson()->String{
        let josnString = """
                              {
                                   "page":1,
                                   "pages":1668,
                                   "perpage":100,
                                   "total":"166731",
                                   "photo":[
                                      {
                                         "id":"48444316461",
                                         "owner":"50444485@N07",
                                         "secret":"7333e18a1d",
                                         "server":"65535",
                                         "farm":66,
                                         "title":"Kitten of Kotor",
                                         "ispublic":1,
                                         "isfriend":0,
                                         "isfamily":0
                                      }
                                   ]
                                }
                         """
        return josnString
    }
    
    func getDemoJsonForSingleSection()->String{
        let josnString = """
                              {
                                   "page":1,
                                   "pages":1,
                                   "perpage":100,
                                   "total":"166731",
                                   "photo":[
                                      {
                                         "id":"48444316461",
                                         "owner":"50444485@N07",
                                         "secret":"7333e18a1d",
                                         "server":"65535",
                                         "farm":66,
                                         "title":"Kitten of Kotor",
                                         "ispublic":1,
                                         "isfriend":0,
                                         "isfamily":0
                                      }
                                   ]
                                }
                         """
        return josnString
    }


}
