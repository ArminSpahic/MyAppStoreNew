//
//  AppDetailsScreenshotsImageCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 26/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit
import SDWebImage

class AppDetailsScreenshotsImageCell: UICollectionViewCell {
    
    var screenShotUrl: String? {
        didSet {
            guard let url = URL(string: screenShotUrl ?? "") else {return}
            screenShotImageView.sd_setImage(with: url) { (_, _, _, _) in
                self.activityIndicator.stopAnimating()
            }
            
        }
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.color = .gray
        ai.hidesWhenStopped = true
        ai.startAnimating()
        ai.isHidden = false
        return ai
    }()
    
    let screenShotImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 8 
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(screenShotImageView)
        addSubview(activityIndicator)
        
        screenShotImageView.fillSuperview()
        activityIndicator.fillSuperview()
    }
    
}
