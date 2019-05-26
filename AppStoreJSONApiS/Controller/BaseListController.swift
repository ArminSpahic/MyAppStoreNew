//
//  BaseListController.swift
//  AppStoreJSONApis
//
//  Created by Armin Spahic on 05/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
