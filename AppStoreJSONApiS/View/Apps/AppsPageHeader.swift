//
//  AppsPageHeader.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 17/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    let appHorizontalController = AppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(appHorizontalController.view)
        appHorizontalController.view.fillSuperview()
        
    }
    
}
