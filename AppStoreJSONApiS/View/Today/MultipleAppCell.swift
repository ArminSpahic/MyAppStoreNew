//
//  MultipleAppCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 03/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
    
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
    
    let separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    let appNameLabel = UILabel(text: "TEST", font: .systemFont(ofSize: 18))
    
    let appSubtitleLabel = UILabel(text: "TEST", font: .systemFont(ofSize: 12))
    
    let getBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13 )
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 26).isActive = true
        button.layer.cornerRadius = 12
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
        appSubtitleLabel.textColor = .lightGray
        appIconImageView.constrainHeight(constant: self.frame.height)
        appIconImageView.constrainWidth(constant: self.frame.height)
        appIconImageView.backgroundColor = .green
        let overallStackView = UIStackView(arrangedSubviews: [appIconImageView, VerticalStackView(arrangedSubviews: [appNameLabel, appSubtitleLabel]), getBtn])
        overallStackView.spacing = 10
        overallStackView.axis = .horizontal
        overallStackView.alignment = .center
        addSubview(overallStackView)
        overallStackView.fillSuperview()
        
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: appNameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0), size: .init(width: 0, height: 0.5))
    }
    
}
