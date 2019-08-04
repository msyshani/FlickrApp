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
        print(url)
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
            let flickrModel = try JSONDecoder().decode(PhotoSearchResultWrapper.self, from: data)
            return flickrModel.result
        }catch{
            print(error)
        }
        return nil
    }

}
