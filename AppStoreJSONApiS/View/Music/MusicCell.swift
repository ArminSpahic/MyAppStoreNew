//
//  MusicCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 15/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit
import SDWebImage

class MusicCell: UICollectionViewCell {
    
    var result: Result? {
        didSet {
            guard let result = result else {return}
            musicImageView.sd_setImage(with: URL(string: result.artworkUrl100 ?? ""), completed: nil)
            titleLabel.text = result.trackName
            subtitleLabel.text = "\(result.artistName ?? "") * \(result.collectionName ?? "")"
        }
    }
    
    let musicImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .green
        iv.layer.cornerRadius = 10
        iv.image = #imageLiteral(resourceName: "holiday")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.constrainWidth(constant: 72)
        iv.constrainHeight(constant: 72)
        return iv
    }()
    
    let titleLabel = UILabel(text: "Wildest Dreams", font: .boldSystemFont(ofSize: 16))
    
    let subtitleLabel = UILabel(text: "Taylor Swift - 1989 - Pop", font: .systemFont(ofSize: 14))
    
    let separatorView: UIView = {
        let sv = UIView()
        sv.backgroundColor = UIColor(white: 0.5, alpha: 0.5 )
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        subtitleLabel.numberOfLines = 2
        
        let stackView = UIStackView(arrangedSubviews: [musicImageView, VerticalStackView(arrangedSubviews: [titleLabel, subtitleLabel], spacing: 6)])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 16, bottom: 20, right: 16))
        
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
    }
    
}
