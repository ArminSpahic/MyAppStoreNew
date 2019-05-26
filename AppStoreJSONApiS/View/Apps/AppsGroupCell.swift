//
//  AppsGroupCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 15/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
        
    let appsHorizontalViewController = AppsHorizontalController()
    
    let cellId = "cellId"
    
    let titleLabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 30))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        appsHorizontalViewController.collectionView.reloadData()
        addSubview(titleLabel)
        addSubview(appsHorizontalViewController.view)
        
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        
        appsHorizontalViewController.view.anchor(top: titleLabel.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
    }
}
