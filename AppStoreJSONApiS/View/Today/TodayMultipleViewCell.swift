//
//  TodayMultipleViewCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 03/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class TodayMultipleViewCell: BaseTodayCell {
    
    override var todayItem: TodayItem? {
        didSet {
            guard let item = todayItem else {return}
            categoryLabel.text = item.category
            titleLabel.text = item.title
            backgroundColor = item.backgroundColor
            
            multipleAppsController.apps = item.apps
            multipleAppsController.collectionView.reloadData()
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 26), numberOflines: 2)
    let multipleAppsController = TodayMultipleAppsController(mode: .small)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        backgroundColor = .white
                
        layer.cornerRadius = 16
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, multipleAppsController.view], spacing: 10)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        
    }
    
}
