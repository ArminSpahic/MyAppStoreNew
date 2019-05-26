//
//  AppsHorizontalController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 15/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController {
    
    var feed: Feed? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(AppItemCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed?.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppItemCell
        if let feedForCell = feed {
        cell.appResult = feedForCell.results[indexPath.item]
        }
        return cell
    }
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - (topBottomPadding * 2) - (lineSpacing * 2) ) / 3
        return CGSize(width: self.view.frame.width - 40, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    var didSelectHandler: ((AppResult) -> ())?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = feed?.results[indexPath.item ] {
        didSelectHandler?(app)
        }
    }
    
}
