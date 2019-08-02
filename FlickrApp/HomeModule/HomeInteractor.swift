//
//  HomeInteractor.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 02/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class HomeInteractor: NSObject {
    weak var presenter:HomeInteractorToPresenterProtocol?

}

extension HomeInteractor : HomePresenterToInteractorProtocol{
    func searchImageFromService(withText query:String, page:Int, pageCount:Int){
        
    }
    
    /// return an array of FlickrModel.
    ///
    /// - Parameters:
    ///   - data: The data has to convert in model Array.
    /// - Returns: A FlickrModel Array for the search result.
    private func getModelArray(fromData data:Data)->[FlickrPhoto]?{
        do{
            let flickrModelArray = try JSONDecoder().decode([FlickrPhoto].self, from: data)
            return flickrModelArray
        }catch{
            print(error)
        }
        return nil
    }
}
