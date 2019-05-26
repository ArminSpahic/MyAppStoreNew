//
//  AppsHeaderCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 18/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit
import SDWebImage

class AppHeaderCell: UICollectionViewCell {
    
    var socialApp: SocialApp? {
        didSet {
            guard let categoryText = socialApp?.name else {return}
            guard let titleText = socialApp?.tagline else {return}
            guard let headerImageUrlString = socialApp?.imageUrl else {return}
            
            categoryLabel.text = categoryText
            titleLabel.text = titleText
            headerImageView.sd_setImage(with: URL(string: headerImageUrlString), completed: nil)
            
        }
    }
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26)
        label.numberOfLines = 0
        return label
    }()
    
    let headerImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 6
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, headerImageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
}
