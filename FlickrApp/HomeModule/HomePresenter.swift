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
    var page = 1
    private var hasMoreData = false
    private var isLoadingNextPage: Bool = false
    
    var queryText: String = "" {
        didSet {
            guard queryText != oldValue else {
                return
            }
            self.searchPhoto(withText: self.queryText)
        }
    }
    
    
    enum SearchState {
        case idle
        case searching
        case error
    }
    
     var searchState: SearchState = .idle {
        didSet {
            guard searchState != oldValue else {
                return
            }
            
            switch searchState {
            case .idle:
                self.view?.showIdealState()
            case .searching:
                self.view?.showSearchingState()
            case .error:
                self.view?.showErrorState(message: Contstants.Message.ERROR)
            }
        }
    }

}

//MARK: - HomeViewToPresenterProtocol
extension HomePresenter : HomeViewToPresenterProtocol{
    
    func viewDidLoad() {
        //self.searchPhoto(withText: self.queryText)
    }
    
    func searchPhoto(withText query: String) {
        if query == ""{
            return
        }
        self.page = 1
        imageArray = [FlickrPhoto]()
        hasMoreData = false
        self.view?.reloadTable()
        searchState = .searching
        self.interactor?.searchImageFromService(withText: queryText, page: page, pageCount: 100)
    }
    
    func searchMorePhotos(withText query: String) {
        guard !isLoadingNextPage && hasMoreData else {
            return
        }
        isLoadingNextPage = true
        self.interactor?.searchImageFromService(withText: queryText, page: page, pageCount: 100)
    }
    
    func numberOfSection() -> Int {
        return self.hasMoreData ? 2 : 1
    }
    
    func numberOfRow(inSection section: Int) -> Int {
        if section == 0 {
            return imageArray.count
        }
        return 1
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
        var url = Contstants.IMAGE_URL.BASE_URL
        if let farm = photo.farm{
            url = url.replacingOccurrences(of: Contstants.IMAGE_URL.FARM, with: String(farm))
        }
        if let server = photo.server{
            url = url.replacingOccurrences(of: Contstants.IMAGE_URL.SERVER, with: String(server))
        }
        if let secret = photo.secret{
            url = url.replacingOccurrences(of: Contstants.IMAGE_URL.SECRET, with: secret)
        }
        if let id = photo.id{
            url = url.replacingOccurrences(of: Contstants.IMAGE_URL.ID, with: id)
        }
        return url
    }
    
    
}

//MARK: - HomeInteractorToPresenterProtocol
extension HomePresenter : HomeInteractorToPresenterProtocol{
    func imageFetchingRequestCompletedSuccessfully(model:PhotoSearchResult){
            if self.page == 1{
                self.imageArray = model.photos
            } else {
                self.imageArray.append(contentsOf: model.photos)
            }
            self.searchState = .idle
            self.page = self.page + 1
            self.hasMoreData = model.page < model.pages
            self.isLoadingNextPage = false
            DispatchQueue.main.async {
               self.view?.reloadTable()
            }
    }
    
    func imgaeFetchingRequestFailed(withError error: Error) {
        DispatchQueue.main.async {
            self.searchState = .error
            self.view?.showErrorState(message: error.localizedDescription)
        }
    }
}



