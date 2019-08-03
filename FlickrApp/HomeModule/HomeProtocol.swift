//
//  HomeProtocol.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 02/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import Foundation


//MARK: Viewcontroller and presenter
protocol HomeViewToPresenterProtocol:class {
    var view:HomePresenterToViewProtocol? {get set}
    var interactor:HomePresenterToInteractorProtocol? {get set}
    var router:HomePresenterToRouterProtocol? {get set}
    
    var imageArray: [Any] { get set }
    var page : Int { get set }
    var queryText :String { get set }
    
    func viewDidLoad()
    func searchPhoto(withText query:String, page:Int, pageCount:Int)
    //TableView
    func numberOfSection()->Int
    func numberOfRow(inSection section:Int)->Int
    func image(atIndexPath index:IndexPath)->Any
    func selectRow(atIndexPath index:IndexPath)
}

protocol HomePresenterToViewProtocol:class {
    var presenter: HomeViewToPresenterProtocol? {get set}
    func reloadTable()
    func displayError(errorMessage:String)
}

//MARK: Presenter and Interactor
protocol HomePresenterToInteractorProtocol:class {
    var presenter:HomeInteractorToPresenterProtocol? {get set}
    func searchImageFromService(withText query:String, page:Int, pageCount:Int)
    
}
protocol HomeInteractorToPresenterProtocol:class {
    func imageFetchingRequestCompletedSuccessfully(modelArray:[FlickrPhoto])
    func imgaeFetchingRequestFailed(withError error: Error)
    
}

//MARK: Presenter and Router
protocol HomePresenterToRouterProtocol:class {
    func pushContactDetailScreen(from view: HomePresenterToViewProtocol?, forContact contact: Any)
    func pushAddContactScreen(from view: HomePresenterToViewProtocol?, forContact contact: Any)
    
}
protocol HomeRouterToPresenterProtocol:class {
    
}
