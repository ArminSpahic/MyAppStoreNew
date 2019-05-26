//
//  TodayHeaderView.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 20/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class TodayHeaderView: UICollectionReusableView {
    
    let dateLabel = UILabel(text: "MONDAY, JANUARY 28", font: .systemFont(ofSize: 18), numberOflines: 1)
    let date = Date()
    let formatter = DateFormatter()
    
    let titleLabel = UILabel(text: "TODAY", font: .boldSystemFont(ofSize: 32))
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .red
        iv.constrainWidth(constant: 54)
        iv.constrainHeight(constant: 54)
        iv.layer.cornerRadius = 27
        iv.image = #imageLiteral(resourceName: "garden")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupTime()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupTime() {
        formatter.dateFormat = "EEEE, MMM d"
        let result = formatter.string(from: date)
        dateLabel.text = result
    }
    
    fileprivate func setupViews() {
        dateLabel.constrainWidth(constant: frame.width * 0.7)
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [dateLabel, titleLabel], spacing: 4)
        let stackView = UIStackView(arrangedSubviews: [verticalStackView, imageView])
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 32, bottom: 0, right: 32))
    }
    
}
