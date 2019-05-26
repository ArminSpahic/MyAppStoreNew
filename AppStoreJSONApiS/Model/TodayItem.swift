//
//  TodayItem.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 02/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

struct TodayItem {
    
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    var cellType: CellType
    
    let apps: [AppResult]
    
    enum CellType: String {
        case normal, multiple
    }
    
}
