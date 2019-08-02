//
//  APIRequest.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 03/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class APIRequests : APIRequest{
    //API key
    private static let apiKey = "3e7cc266ae2b0e0d78e279ce8e361736"
    /// return an UrlRequest.
    ///
    /// - Parameters:
    ///   - dic: has all components required to create url.
    /// - Returns: An UrlRequest.
    func makeRequest(from dic:[String:String]) throws -> URLRequest? {
        
        let params: [String: String] = ["safe_search": "1",
                                        "page": dic["pageNumber"] ?? "100" ,
                                        "text": dic["query"] ?? "kitten" ,
                                        "api_key": type(of: self).apiKey,
                                        "nojsoncallback":"1",
                                        "per_page": dic["pageCount"] ?? "1",
                                        "method":"flickr.photos.search"]
        
        let url = try? URLEncoder().urlWith(urlString: "https://api.flickr.com/services/rest/", parameters: params)
        let urlRequest = URLRequest(url: url!)
        return urlRequest
    }
    
    func parseResponse(data: Data) throws -> String?{
        return nil
    }

}
