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
    /// This property can be used to avoid displaying the wrong image when reusing cells.
    var imageId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgView.image = nil
    }
    
}
