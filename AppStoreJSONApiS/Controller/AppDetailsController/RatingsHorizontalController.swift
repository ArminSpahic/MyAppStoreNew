//
//  RatingsHorizontalController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 29/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class RatingsHorizontallController: HorizontalSnappingController {
    
    var reviews: Reviews? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailsReviewCommentsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppDetailsReviewCommentsCell
        
        let entry = reviews?.feed.entry[indexPath.item]
        cell.entry = entry
        
        for (index, view) in cell.starsStackView.arrangedSubviews.enumerated() {
            if let ratingInt = Int(entry?.rating.label ?? "") {
                view.alpha = index >= ratingInt ? 0 : 1
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
}
