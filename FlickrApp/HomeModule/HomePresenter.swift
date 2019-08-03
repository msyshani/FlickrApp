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
    
    func getImageUrl(atIndexPath index:IndexPath)->String{
        let urlStr = self.path(for: imageArray[index.row])
        return urlStr
    }
    
    func image(atIndexPath index:IndexPath)->FlickrPhoto{
        return imageArray[index.row]
    }
    
    func selectRow(atIndexPath index: IndexPath) {
        
    }
    
    private func path(for photo: FlickrPhoto) -> String {
        var url = "http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg"
        if let farm = photo.farm{
            url = url.replacingOccurrences(of: "{farm}", with: String(farm))
        }
        if let server = photo.server{
            url = url.replacingOccurrences(of: "{server}", with: String(server))
        }
        if let secret = photo.secret{
            url = url.replacingOccurrences(of: "{secret}", with: secret)
        }
        if let id = photo.id{
            url = url.replacingOccurrences(of: "{id}", with: id)
        }
        return url
    }
    
    
}

//MARK: - HomeInteractorToPresenterProtocol
extension HomePresenter : HomeInteractorToPresenterProtocol{
    func imageFetchingRequestCompletedSuccessfully(model:PhotoSearchResult){
        DispatchQueue.main.async {
            self.page = self.page + 1
            self.imageArray = model.photos
            self.hasMoreData = model.page < model.pages
            self.view?.reloadTable()
        }
    }
    
    func imgaeFetchingRequestFailed(withError error: Error) {
        DispatchQueue.main.async {
            self.view?.displayError(errorMessage: error.localizedDescription)
        }
    }
}



