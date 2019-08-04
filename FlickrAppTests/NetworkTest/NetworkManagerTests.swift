//
//  NetworkManagerTests.swift
//  SampleProjectTests
//
//  Created by Mahendra Yadav on 04/08/19.
//  Copyright © 2018 Avadesh Kumar. All rights reserved.
//

import XCTest
@testable import FlickrApp

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        
    }
}

protocol JSONMockable {
    func getMockJSON() -> [String: Any]
}

extension JSONMockable {
    
    func getMockJSON() -> [String: Any] {
        
        let mockJSON: [String: Any] = ["page":2,"results":[["backdrop_path":"/g6WT9zxATzTy9NVu2xwbxDAxvjd.jpg","genre_ids":[28,12,878],"id": 157350,"original_language":"en","overview":"Trislearnsthatshe's been classified as Divergent and too late.","poster_path":"/yTtx2ciqk4XdN1oKhMMDy3f5ue3.jpg","release_date":"2014-03-14","title":"Divergent"]],"total_pages":18597,"total_results":371921]
        return mockJSON
    }
}


class MockAPIRequest: APIRequest {
    var numberOfTimesMakeRequestCalled: Int = 0
    var numberOfTimesParseResponseCalled: Int = 0
    var numberOfTimesShouldCacheRsponseCalled: Int = 0
    
    private static let apiKey = "3e7cc266ae2b0e0d78e279ce8e361736"
    
    func makeRequest(from dic:[String:String]) throws -> URLRequest? {
        numberOfTimesMakeRequestCalled = numberOfTimesMakeRequestCalled + 1
        
        var params: [String: String] = [Contstants.API.KEY.METHODS     : Contstants.API.VALUE.METHODS,
                                        Contstants.API.KEY.API_KEY     : type(of: self).apiKey,
                                        Contstants.API.KEY.FORMAT      : Contstants.API.VALUE.FORMAT,
                                        Contstants.API.KEY.CALLBACK    : Contstants.API.VALUE.CALLBACK,
                                        Contstants.API.KEY.SAFE_SEARCH : Contstants.API.VALUE.SAFE_SEARCH]
        
        if let text = dic[Contstants.API.KEY.TEXT]{
            params[Contstants.API.KEY.TEXT] = text
        }
        if let pageNumber = dic[Contstants.API.KEY.PAGE]{
            params[Contstants.API.KEY.PAGE] = pageNumber
        }
        if let per_page = dic[Contstants.API.KEY.PER_PAGE]{
            params[Contstants.API.KEY.PER_PAGE] = per_page
        }
        
        let url = try? URLEncoder().urlWith(urlString: Contstants.API.BASE_URL, parameters: params)
        let urlRequest = URLRequest(url: url!)
        return urlRequest
    }
    
    func parseResponse(data: Data) throws -> PhotoSearchResult?{
        numberOfTimesParseResponseCalled = numberOfTimesParseResponseCalled + 1
        do{
            let flickrModel = try JSONDecoder().decode(PhotoSearchResultWrapper.self, from: data)
            return flickrModel.result
        }catch{
            print(error)
        }
        return nil
    }
    
    func shouldCacheResponse() -> Bool {
        numberOfTimesShouldCacheRsponseCalled = numberOfTimesShouldCacheRsponseCalled + 1
        return true
    }
}

class APIRequestLoaderTests: NetworkBaseTest, JSONMockable {
   
    var loader: APIRequestLoader<MockAPIRequest>!
    let request = MockAPIRequest()

    override func setUp() {
        super.setUp()
        
        let urlSession = getURLSessionWithMockConfigurations()
        loader = APIRequestLoader(apiRequest: request, urlSession: urlSession)
    }
    
    func testAPISuccess() {
        
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), self.getMockJSON().toJSONData()!)
        }
        
        let expectation = XCTestExpectation(description: "response")
        loader.loadAPIRequest(requestData: [String:String](), completionHandler: { [weak self] (response, error) in
            
            expectation.fulfill()
            XCTAssertTrue(self?.request.numberOfTimesMakeRequestCalled == 1, "APIRequestLoader: Issue with make request calling")
            XCTAssertTrue(self?.request.numberOfTimesParseResponseCalled == 1, "APIRequestLoader: Issue with parse response calling")
            XCTAssertTrue(self?.request.numberOfTimesShouldCacheRsponseCalled == 1, "APIRequestLoader: Issue with should cache response calling")
        })
        
        wait(for: [expectation], timeout: 1)
    }
}
