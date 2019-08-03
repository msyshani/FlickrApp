//
//  APIRequest.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 03/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class FlickrAPIRequests : APIRequest{
    //API key
    private static let apiKey = "3e7cc266ae2b0e0d78e279ce8e361736"
    /// return an UrlRequest.
    ///
    /// - Parameters:
    ///   - dic: has all components required to create url.
    /// - Returns: An UrlRequest.
    func makeRequest(from dic:[String:String]) throws -> URLRequest? {
        
        var params: [String: String] = ["method": "flickr.photos.search",
                                        "api_key": type(of: self).apiKey,
                                        "format":"json",
                                        "nojsoncallback":"1",
                                        "safe_search" : "1"]
        
        if let text = dic["text"]{
            params["text"] = text
        }
        if let pageNumber = dic["page"]{
            params["page"] = pageNumber
        }
        if let per_page = dic["per_page"]{
            params["per_page"] = per_page
        }
        
        let url = try? URLEncoder().urlWith(urlString: "https://api.flickr.com/services/rest/", parameters: params)
        let urlRequest = URLRequest(url: url!)
        return urlRequest
    }
    
    /// return an array of FlickrModel.
    ///
    /// - Parameters:
    ///   - data: The data has to convert in model Array.
    /// - Returns: A FlickrModel Array for the search result.
    func parseResponse(data: Data) throws -> PhotoSearchResult?{
        do{
            let flickrModelArray = try JSONDecoder().decode(PhotoSearchResult.self, from: data)
            return flickrModelArray
        }catch{
            print(error)
        }
        return nil
    }

}
