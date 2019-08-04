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
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private weak var retryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setUpView()
        registercells()
        presenter?.viewDidLoad()
    }
    

    func registercells(){
        collectionView.registerReusableViewCell(ImageCollectionCell.self)
        collectionView.registerReusableViewCell(ActivityIndicatorCell.self)
    }
    
    func setUpView(){
        searchBar.placeholder = NSLocalizedString("placeholder_search", comment: "Search")
        searchBar.becomeFirstResponder()
        collectionView.isHidden = true
        activityIndicator.isHidden = true
        infoLabel.isHidden = true
        retryButton.isHidden = true
    }
    
    @IBAction private func retryButtonClicked(_ sender: Any) {
        self.presenter?.searchPhoto(withText: self.presenter?.queryText ?? "")
    }
    

}


//MARK: - CollectionView Delegate and Datasource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 0 {
            let width = self.view.frame.width / 3.2
            return CGSize(width: width , height: width)
        }
        
        // The loading more has a fixed height of 44 and is the full width of the view.
        return CGSize(width: self.view.frame.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfRow(inSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell:ImageCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            self.loadPhoto(for: cell, at: indexPath)
            return cell
        case 1:
            let cell:ActivityIndicatorCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        default:
            return UICollectionViewCell()
        }
        
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
        guard indexPath.section == 1 else {
            return
        }
        (cell as! ActivityIndicatorCell).isAnimating = true
        self.presenter?.searchMorePhotos(withText: self.presenter?.queryText ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.section == 1 else {
            return
        }
        (cell as! ActivityIndicatorCell).isAnimating = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.section == 0 {
                if let urlString = presenter?.getImageUrl(atIndexPath: indexPath){
                    ImageDownloader.downloader.getDownloadedImage(urlStr: urlString) { (image) in }
                }
            } else {
                self.presenter?.searchMorePhotos(withText: self.presenter?.queryText ?? "")
            }
        }
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
    
    func showIdealState(){
        self.infoLabel.text = ""
        self.infoLabel.isHidden = true
        self.collectionView.isHidden = false
        self.activityIndicator.isHidden = true
        self.retryButton.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    func showSearchingState(){
        self.infoLabel.text = Contstants.Message.SEARCHING
        self.infoLabel.isHidden = false
        self.collectionView.isHidden = true
        self.activityIndicator.isHidden = false
        self.retryButton.isHidden = true
        self.activityIndicator.startAnimating()
    }
    
    func showErrorState(message:String){
        self.infoLabel.text = message
        self.infoLabel.isHidden = false
        self.collectionView.isHidden = true
        self.activityIndicator.isHidden = true
        self.retryButton.isHidden = false
        self.activityIndicator.stopAnimating()
    }
}


//MARK: - UISearchBarDelegate
extension HomeViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text  == ""{
            searchBar.resignFirstResponder()
            return
        }
        self.presenter?.queryText = searchBar.text ?? ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //overlayControl.isHidden = false
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = self.presenter?.queryText
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //overlayControl.isHidden = true
    }
}
