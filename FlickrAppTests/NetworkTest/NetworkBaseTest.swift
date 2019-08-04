//
//  NetworkBaseTest.swift
//  FlickrAppTests
//
//  Created by Mahendra Yadav on 04/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import XCTest

class NetworkBaseTest: XCTestCase {

    func getURLSessionWithMockConfigurations() -> URLSession {
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: configuration)
        return urlSession
    }

}
