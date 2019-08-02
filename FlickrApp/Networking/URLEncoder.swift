//
//  URLEncoder.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 03/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation

enum URLEncodingError: Swift.Error {
    case URLStringNotURLConvertible
}

protocol URLEncodeble {
    func urlWith(urlString: String, parameters: Dictionary<String, Any>?) throws -> URL?
}

class URLEncoder : URLEncodeble {
    
    /// return an URL.
    ///
    /// - Parameters:
    ///   - urlString: urlString is base url.
    ///   - parameters: parameters is attributes that have to append in url
    /// - Returns: an URL
    func urlWith(urlString: String, parameters: Dictionary<String, Any>?) throws -> URL? {
        
        guard var urlComponents = URLComponents(string: urlString) else {
            throw URLEncodingError.URLStringNotURLConvertible
        }
        
        guard let params = parameters else {
            return urlComponents.url
        }
        
        let items = params.map {
            URLQueryItem(name: String(describing: $0), value: String(describing: $1)) }
        
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = Array<URLQueryItem>()
        }
        
        urlComponents.queryItems?.append(contentsOf: items)
        
        return urlComponents.url
    }

}
