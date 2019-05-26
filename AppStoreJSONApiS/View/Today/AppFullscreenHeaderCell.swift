//
//  AppFullscreenHeaderCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 02/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class AppFullscreenHeaderCell: UITableViewCell {
    
    
    let todayCell = TodayCell()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
       addSubview(todayCell)
        todayCell.fillSuperview()
        
        
    }
    
}
