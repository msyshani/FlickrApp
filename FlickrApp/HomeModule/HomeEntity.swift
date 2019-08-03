//
//  HomeEntity.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 02/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation


/// Search result returned when searching images using `Flickr API service`.
struct PhotoSearchResult: Decodable {
    /// The page that was retrieved.
    var page: Int
    
    /// The number of pages that exist for the search that was done.
    var pages: Int
    
    /// The photos for the currently retrieved page.
    var photos: [FlickrPhoto]
    
    private enum CodingKeys: String, CodingKey {
        case page
        case pages
        case photos = "photo"
    }
}

/// Wrapper for parsing the result from Flickr.
struct PhotoSearchResultWrapper: Decodable {
    var result: PhotoSearchResult
    
    private enum CodingKeys: String, CodingKey {
        case result = "photos"
    }
}


/// Photos returned when searching on Flickr.
struct FlickrPhoto: Decodable {
    
    // MARK: - Properties
    /// The id of the image.
    var id: String
    /// The title of the image.
    var title: String
    
    // MARK: - Image URL Properties
    // The following properties are used to create the url for retrieving the image.
    var farm: Int
    var secret: String
    var server: String
}
