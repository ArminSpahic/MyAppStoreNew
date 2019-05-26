//
//  SearchResultCell.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 06/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var result: Result? {
        didSet {
            imageCollectionView.reloadData()
            if let trackName = result?.trackName {
                nameLabel.text = trackName
                categoryLabel.text = result?.primaryGenreName
            }
            guard let rating = result?.averageUserRating else {return}
            ratingsLabel.text = "\(rating)"
            
            guard let artWorkString = result?.artworkUrl100 else {return}
            let artWorkUrl = URL(string: artWorkString)
            appIconImageView.sd_setImage(with: artWorkUrl, completed: nil)
        }
    }
    
    lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(ScreenShotCell.self, forCellWithReuseIdentifier: cellId)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let appIconImageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Videos"
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        return label
    }()
    
    let getBtn: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
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
        
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        labelsStackView.axis = .vertical
        
        let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getBtn])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center

        let overallStackView = UIStackView(arrangedSubviews: [infoTopStackView, imageCollectionView])
        overallStackView.axis = .vertical
        overallStackView.spacing = 12
        
        addSubview(overallStackView)
        
        overallStackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
   }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result?.screenshotUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenShotCell
        cell.screenShotUrl = result?.screenshotUrls?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.imageCollectionView.frame.width - 20) / 3, height: self.imageCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       let keyWindow = UIApplication.shared.keyWindow
        let view = ImagePresentView()
        view.contentMode = .redraw
        view.setImage(screenShotUrl: result?.screenshotUrls?[indexPath.item] ?? "")
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            keyWindow?.addSubview(view)
            view.fillSuperview()
        }, completion: nil) 
    }
}
