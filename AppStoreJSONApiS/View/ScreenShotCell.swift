//
//  ScreenShotCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 09/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit
import SDWebImage

class ScreenShotCell: UICollectionViewCell {
    
    var screenShotUrl: String? {
        didSet {
            guard let screenShot = screenShotUrl else {return}
            screenShotImageView.sd_setImage(with: URL(string: screenShot), completed: nil)
        }
    }
    
    let screenShotImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
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
        screenShotImageView.fillSuperview()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        screenShotImageView.image = nil
    }
    
}
