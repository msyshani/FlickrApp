//
//  HomePresenter.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 02/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class HomePresenter {
    weak var view:HomePresenterToViewProtocol?
    var interactor:HomePresenterToInteractorProtocol?
    var router:HomePresenterToRouterProtocol?
    //.....
    var imageArray = [FlickrPhoto]()
    var queryText = "kitten"
    var page = 1

}

extension HomePresenter : HomeInteractorToPresenterProtocol{
    
    func imageFetchingRequestCompletedSuccessfully(modelArray:[FlickrPhoto]){
        DispatchQueue.main.async {
           self.imageArray = modelArray
            self.view?.reloadTable()
        }
    }
    
    func imgaeFetchingRequestFailed(withError error: Error) {
        DispatchQueue.main.async {
            self.view?.displayError(errorMessage: error.localizedDescription)
        }
        
    }
    
}



