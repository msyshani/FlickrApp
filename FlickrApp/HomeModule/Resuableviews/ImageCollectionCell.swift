//
//  ImageCollectionCell.swift
//  FlickrApp
//
//  Created by Developer on 03/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell,ReusableViewProtocol {
    //ReuseHandler
    static var reuseIdentifier = "ImageCollectionCell"
    static var nib: UINib? {
        return UINib(nibName: String(describing: ImageCollectionCell.self), bundle: nil)
    }
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgView.image = nil
    }
    
    func configureCell(model:FlickrPhoto){
        var url = "http://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg"
        if let farm = model.farm{
            url = url.replacingOccurrences(of: "{farm}", with: String(farm))
        }
        if let server = model.server{
            url = url.replacingOccurrences(of: "{server}", with: String(server))
        }
        if let secret = model.secret{
            url = url.replacingOccurrences(of: "{secret}", with: secret)
        }
        if let id = model.id{
            url = url.replacingOccurrences(of: "{id}", with: id)
        }
        
        
        
    }

}
