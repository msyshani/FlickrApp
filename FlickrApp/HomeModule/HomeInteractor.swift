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
}
