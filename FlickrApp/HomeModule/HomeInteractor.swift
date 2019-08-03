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
    let flickerAPIService: APIRequestLoader<FlickrAPIRequests> = APIRequestLoader(apiRequest: FlickrAPIRequests())
    

}

extension HomeInteractor : HomePresenterToInteractorProtocol{
    func searchImageFromService(withText query:String, page:Int, pageCount:Int){
        let params: [String: String] = ["page": String(page) ,
                                        "text": query,
                                        "per_page": String(pageCount)]
        //Fetch image array from server
        flickerAPIService.loadAPIRequest(requestData: params) { [weak self ] (modelArray, error) in
            if let photoArray = modelArray{
                if photoArray.count > 0{
                    self?.presenter?.imageFetchingRequestCompletedSuccessfully(modelArray: photoArray)
                }else{
                    self?.presenter?.imgaeFetchingRequestFailed(withError: FlickrServiceError.noData)
                }
                
            }else{
                self?.presenter?.imgaeFetchingRequestFailed(withError: FlickrServiceError.parsingFailed)
            }
        }
    }
}
