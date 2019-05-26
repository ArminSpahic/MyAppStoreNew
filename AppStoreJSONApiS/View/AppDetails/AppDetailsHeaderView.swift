//
//  AppDetailsHeaderView.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 25/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit
import SDWebImage

class AppDetailsHeaderView: UICollectionReusableView {
    
    var app: Result? {
        didSet {
            if let appResult = app {
            detailsImageView.sd_setImage(with: URL(string: appResult.artworkUrl100 ?? ""), completed: nil)
            titleLabel.text = appResult.trackName
            descriptionLabel.text = appResult.description
            getBtn.setTitle(appResult.formattedPrice, for: .normal)
            releaseNotes.text = appResult.releaseNotes
            }
        }
    }
    
    let detailsImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.widthAnchor.constraint(equalToConstant: 120).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return iv
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Fortnite"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Works with: iPhone SE, 6S, 7, 8, XS, XR; iPad Mini 4,"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 2
        return label
    }()
    
    let getBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Free", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3373286128, green: 0.6810569763, blue: 1, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16 )
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    let whatsNewLabel: UILabel = {
       let label = UILabel()
        label.text = "What's new"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    let releaseNotes: UILabel = {
       let label = UILabel()
        label.text = "Release notes"
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [titleLabel, descriptionLabel, getBtn], spacing: 8)
        verticalStackView.alignment = .leading
        
        let horizontalStackView = UIStackView(arrangedSubviews: [detailsImageView, verticalStackView])
        horizontalStackView.spacing = 12
        horizontalStackView.alignment = .top
        
        let overallVerticalStackView = VerticalStackView(arrangedSubviews: [horizontalStackView, VerticalStackView(arrangedSubviews: [whatsNewLabel, releaseNotes], spacing: 12)], spacing: 12)
        overallVerticalStackView.alignment = .leading
        
        addSubview(overallVerticalStackView)
        overallVerticalStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
}
