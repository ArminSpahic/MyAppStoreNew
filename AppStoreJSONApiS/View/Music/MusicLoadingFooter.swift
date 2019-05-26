//
//  MusicLoadingFooter.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 15/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .darkGray
        aiv.startAnimating()
        
        let label = UILabel(text: "Loading more...", font: .boldSystemFont(ofSize: 16))
        label.constrainWidth(constant: frame.width)
        label.textAlignment = .center
        label.textColor = .lightGray
        
        let stackView = VerticalStackView(arrangedSubviews: [aiv, label], spacing: 8)
        
        addSubview(stackView)
        stackView.centerInSuperview()
    }
    
}
