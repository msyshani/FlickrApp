//
//  HomeViewController.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 02/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var presenter: HomeViewToPresenterProtocol?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var infoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        registercells()
        presenter?.viewDidLoad()
        setUpView()
    }
    

    func registercells(){
        collectionView.registerReusableViewCell(ImageCollectionCell.self)
    }
    
    func setUpView(){
        collectionView.isHidden = true
        activityIndicator.isHidden = false
        infoLabel.isHidden = false
    }

}


//MARK: - CollectionView Delegate and Datasource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let width = self.view.frame.width / 3.2
        return CGSize(width: width , height: width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.imageArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:ImageCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        self.loadPhoto(for: cell, at: indexPath)
        return cell
    }
    
    private func loadPhoto(for cell: ImageCollectionCell, at indexPath: IndexPath) {
        let photo = self.presenter?.image(atIndexPath: indexPath)
        cell.imageId = photo?.id
        
        cell.imgView.image = nil
        if let urlString = presenter?.getImageUrl(atIndexPath: indexPath){
            ImageDownloader.downloader.getDownloadedImage(urlStr: urlString) { (image) in
                guard cell.imageId == photo?.id else {
                    return
                }
                if let img = image{
                    cell.imgView.image = img
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

//MARK: - HomePresenterToViewProtocol
extension HomeViewController : HomePresenterToViewProtocol{
    func reloadTable() {
        activityIndicator.stopAnimating()
        infoLabel.isHidden = true
        self.collectionView.isHidden = false
        self.collectionView.reloadData()
    }
    
    func displayError(errorMessage: String) {
        
    }
    
    
}
