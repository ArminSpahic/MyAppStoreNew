//
//  AppItemCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 15/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit
import SDWebImage

class AppItemCell: UICollectionViewCell {
    
    var appResult: AppResult? {
        didSet {
            guard let appName = appResult?.name else {return}
            guard let appSubtitle = appResult?.artistName else {return}
            guard let appIconString = appResult?.artworkUrl100 else {return}
            
            appNameLabel.text = appName
            appSubtitleLabel.text = appSubtitle
            appIconImageView.sd_setImage(with: URL(string: appIconString), completed: nil)
        }
    }
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    let appNameLabel = UILabel(text: "TEST", font: .systemFont(ofSize: 20))
    
    let appSubtitleLabel = UILabel(text: "TEST", font: .systemFont(ofSize: 13))
    
    let getBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16 )
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        appIconImageView.constrainHeight(constant: self.frame.height)
        appIconImageView.constrainWidth(constant: self.frame.height)
        let overallStackView = UIStackView(arrangedSubviews: [appIconImageView, VerticalStackView(arrangedSubviews: [appNameLabel, appSubtitleLabel]), getBtn])
        overallStackView.spacing = 10
        overallStackView.axis = .horizontal
        overallStackView.alignment = .center
        addSubview(overallStackView)
        overallStackView.fillSuperview()
    }
    
}
