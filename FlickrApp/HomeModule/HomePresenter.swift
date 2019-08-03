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
    private var hasMoreData = false

}

//MARK: - HomeViewToPresenterProtocol
extension HomePresenter : HomeViewToPresenterProtocol{

    func viewDidLoad() {
        self.searchPhoto(withText: self.queryText, page: self.page)
    }
    
    func searchPhoto(withText query: String, page: Int) {
        if query == ""{
            return
        }
        self.page = 1
        imageArray = [FlickrPhoto]()
        hasMoreData = false
        self.view?.reloadTable()
        self.interactor?.searchImageFromService(withText: queryText, page: page, pageCount: 100)
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRow(inSection section: Int) -> Int {
        return imageArray.count
    }
    
    func image(atIndexPath index:IndexPath)->FlickrPhoto{
        return imageArray[index.row]
    }
    
    func selectRow(atIndexPath index: IndexPath) {
        
    }
    
    
}

//MARK: - HomeInteractorToPresenterProtocol
extension HomePresenter : HomeInteractorToPresenterProtocol{
    func imageFetchingRequestCompletedSuccessfully(modelArray:[FlickrPhoto]){
        DispatchQueue.main.async {
            self.page = self.page + 1
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



