//
//  HomeRouter.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 02/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class HomeRouter{
    static var bundle : Bundle? {
        return Bundle.init(identifier: "com.msy.FlickrApp")
    }
    
    static var storyboard : UIStoryboard {
        return UIStoryboard(name: "Main", bundle: bundle)
    }
    
    static func createHomeModule()->UINavigationController?{
        let navController:UINavigationController = storyboard.instantiateViewController(withIdentifier: "FlickrNavigationController") as! UINavigationController
        
        if let viewController = navController.children.first as? HomeViewController {
            let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol  = HomePresenter()
            let interactor : HomePresenterToInteractorProtocol = HomeInteractor(with: APIRequestLoader(apiRequest: FlickrAPIRequests()))
            let router : HomePresenterToRouterProtocol = HomeRouter()
            
            //Presenter
            presenter.view = viewController
            presenter.interactor = interactor
            presenter.router = router
            //Interatcor
            interactor.presenter = presenter
            //View
            viewController.presenter = presenter
            return navController
        }
        
        return UINavigationController()
    }
}

extension HomeRouter : HomePresenterToRouterProtocol{
    
    
}
