//
//  ImageDownloader.swift
//  FlickrDemo
//
//  Created by Mahendra Yadav on 31/07/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class ImageDownloader {
    static var downloader = ImageDownloader()
    var imageCache = NSCache<NSString, AnyObject>()
    
     init() {
        imageCache.countLimit = 1000
        NotificationCenter.default.addObserver(self, selector: #selector(clearAllImages), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    func getDownloadedImage(urlStr:String, onCompletion:@escaping (UIImage?)->Void){
        
        if let url = URL(string: urlStr){
            if let imageFromCache = imageCache.object(forKey: urlStr as NSString) as? UIImage {
                onCompletion(imageFromCache)
                return
            }
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        if let img = UIImage(data: data){
                            self.imageCache.setObject(img, forKey: urlStr as NSString)
                            onCompletion(img)
                        }else{
                            onCompletion(nil)
                        }
                    }
                    
                }else{
                    onCompletion(nil)
                }
            }
        }
        
    }
    
    @objc func clearAllImages() {
        imageCache.removeAllObjects()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }

}
