//
//  Constant.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 04/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation

struct Contstants {
    struct API {
        static let BASE_URL = "https://api.flickr.com/services/rest/"
        struct KEY {
            static let METHODS = "method"
            static let API_KEY = "api_key"
            static let FORMAT = "format"
            static let CALLBACK = "nojsoncallback"
            static let SAFE_SEARCH = "safe_search"
            static let TEXT = "text"
            static let PAGE = "page"
            static let PER_PAGE = "per_page"
        }
        struct VALUE {
            static let METHODS = "flickr.photos.search"
            static let FORMAT = "json"
            static let CALLBACK = "1"
            static let SAFE_SEARCH = "1"
        }
        
    }
    struct Message {
        static let SEARCHING = "Please wait. we are fetching images for you."
        static let ERROR = "We are unable to process your request, Please try again later"
        static let INVALID_DATA = "Invalid image data"
        static let PARSING_ERROR = "We are unable to parse your request, Please try after some time"
        static let NO_DATA = "No image found for your search"
    }
    
    struct IMAGE_URL {
        static let BASE_URL = "http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg"
        static let FARM = "{farm}"
        static let SERVER = "{server}"
        static let SECRET = "{secret}"
        static let ID = "{id}"
    }
  
}
