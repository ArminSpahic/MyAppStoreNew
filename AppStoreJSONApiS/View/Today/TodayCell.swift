//
//  TodayCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 01/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class TodayCell: BaseTodayCell {
    
    var topConstraint: NSLayoutConstraint!
    
   override var todayItem: TodayItem? {
        didSet {
            guard let item = todayItem else {return}
            categoryLabel.text = item.category
            titleLabel.text = item.title
            todayImageView.image = item.image
            descriptionLabel.text = item.description
            backgroundColor = item.backgroundColor
            backgroundView?.backgroundColor = item.backgroundColor
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 26))
    let todayImageView = UIImageView(image: UIImage(named: "garden"))
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way", font: .systemFont(ofSize: 16), numberOflines: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        backgroundColor = .white
        todayImageView.contentMode = .scaleAspectFill
        todayImageView.clipsToBounds = true
        //clipsToBounds = true
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(todayImageView)
        todayImageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel], spacing: 8)
        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        
        //possible to do to isolate top constraint
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint.isActive = true
    }
    
}
