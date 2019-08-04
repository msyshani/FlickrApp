//
//  Extensions.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 04/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation

extension Data {
    
    func toJSONObject() -> Any? {
        
        let object = try? JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments)
        return object
    }
}


extension Dictionary {
    
    func toJSONData() -> Data? {
        
        let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        return data
    }
}
