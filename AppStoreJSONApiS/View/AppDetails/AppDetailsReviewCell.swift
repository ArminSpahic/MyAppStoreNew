//
//  AppDetailsReviewCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 29/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class AppDetailsReviewCell: UICollectionViewCell {
    
    var ratingsHorizontalController = RatingsHorizontallController()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Reviews & Ratings"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(titleLabel)
        addSubview(ratingsHorizontalController.view)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
        ratingsHorizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 16))
    }
    
}
