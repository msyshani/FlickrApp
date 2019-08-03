//
//  ActivityIndicatorCell.swift
//  FlickrApp
//
//  Created by Mahendra Yadav on 03/08/19.
//  Copyright © 2019 AppEngineer. All rights reserved.
//

import UIKit

class ActivityIndicatorCell: UICollectionViewCell,ReusableViewProtocol {
    //ReuseHandler
    static var reuseIdentifier = "ActivityIndicatorCell"
    static var nib: UINib? {
        return UINib(nibName: String(describing: ActivityIndicatorCell.self), bundle: nil)
    }
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Indicates whether the activity indicator is currently animating. The default value is `false`.
    var isAnimating: Bool = false {
        didSet {
            guard isAnimating != oldValue else {
                return
            }
            if isAnimating {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }
        }
    }

}
