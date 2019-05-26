//
//  AppDetailsReviewCommentsCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 29/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class AppDetailsReviewCommentsCell: UICollectionViewCell {
    
    var entry: Entry? {
        didSet {
            guard let title = entry?.title.label else {return}
            guard let userTitle = entry?.author.name.label else {return}
            guard let bodyText = entry?.content.label else {return}
            
            reviewTitleLabel.text = title
            userTitleLabel.text = userTitle
            bodyLabel.text = bodyText
        }
    }
    
    let reviewTitleLabel = UILabel(text: "Ridicoulus bugs", font: .systemFont(ofSize: 18))
    let userTitleLabel = UILabel(text: "Anonymous syka", font: .systemFont(ofSize: 16))
    
    lazy var starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach { (_) in
            let imageView = UIImageView(image: UIImage(named: "star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        }
        
        arrangedSubviews.append(UIView())
        
       let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    
    let bodyLabel = UILabel(text: "Review body\nReview body\nReview body", font: .systemFont(ofSize: 16), numberOflines: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        backgroundColor = #colorLiteral(red: 0.9501578212, green: 0.9450401664, blue: 0.9814406037, alpha: 1)
        layer.cornerRadius = 16
        userTitleLabel.textAlignment = .right
        reviewTitleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [reviewTitleLabel, userTitleLabel])
        horizontalStackView.spacing = 10
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [horizontalStackView, starsStackView, bodyLabel], spacing: 12)
        
        let scrollView = UIScrollView()
        addSubview(scrollView)
        
        scrollView.addSubview(verticalStackView)

        addSubview(verticalStackView)
        verticalStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        
    }
    
}
