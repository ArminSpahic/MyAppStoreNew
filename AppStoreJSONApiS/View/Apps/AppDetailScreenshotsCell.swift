//
//  AppDetailScreenshotsCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 25/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class AppDetailsPreviewCell: UICollectionViewCell {
    
    let previewLabel: UILabel = {
       let label = UILabel()
        label.text = "Preview"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let appDetailsHorizontalController = AppDetailsHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(previewLabel)
        addSubview(appDetailsHorizontalController.view)
        
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 16, bottom: 0, right: 16))
        
        appDetailsHorizontalController.view.anchor(top: previewLabel.bottomAnchor, leading: previewLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0))
    }
    
}
