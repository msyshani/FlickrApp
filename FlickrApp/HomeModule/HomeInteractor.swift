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
    let flickerAPIService: APIRequestLoader<FlickrAPIRequests>
    
    init(with request: APIRequestLoader<FlickrAPIRequests>) {
        self.flickerAPIService = request
    }
    
}

extension HomeInteractor : HomePresenterToInteractorProtocol{
    func searchImageFromService(withText query:String, page:Int, pageCount:Int){
        let params: [String: String] = ["page": String(page) ,
                                        "text": query,
                                        "per_page": String(pageCount)]
        //Fetch image array from server
        flickerAPIService.loadAPIRequest(requestData: params) { [weak self ] (model, error) in
            if let photoModel = model{
                if photoModel.photos.count > 0{
                    self?.presenter?.imageFetchingRequestCompletedSuccessfully(model: photoModel)
                }else{
                    self?.presenter?.imgaeFetchingRequestFailed(withError: FlickrServiceError.noData)
                }
                
            }else{
                self?.presenter?.imgaeFetchingRequestFailed(withError: FlickrServiceError.parsingFailed)
            }
        }
    }
}
