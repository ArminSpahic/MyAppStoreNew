//
//  AppDetailsController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 22/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class AppDetailsController: BaseListController {
    
    fileprivate let appId: String
    
    init(appId: String) {
        self.appId = appId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerId = "headerId"
    let cellId = "cellId"
    let ratingsCellId = "ratingsCellId"
    
    var app: Result?
    var reviews: Reviews?
    
    fileprivate func fetchData() {
        Service.shared.fetchAppDetails(id: appId) { (result, err) in
            print("Result:", result?.results)
            guard let app = result?.results.first else {return}
            self.app = app
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        Service.shared.fetchAppDetailsReviews(id: appId) { (reviews, err) in
            self.reviews = reviews
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(AppDetailsPreviewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppDetailsReviewCell.self, forCellWithReuseIdentifier: ratingsCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppDetailsHeaderView
        header.app = app
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppDetailsPreviewCell
        cell.appDetailsHorizontalController.app = app
        return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ratingsCellId, for: indexPath) as! AppDetailsReviewCell
            cell.ratingsHorizontalController.reviews = reviews
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        
        if indexPath.item == 0 {
            height = TodayCollectionController.cellHeight
        } else {
            height = 280
        }
        
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let dummyCell = AppDetailsHeaderView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        dummyCell.app = app
        dummyCell.layoutIfNeeded()
        
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        
        return CGSize(width: self.view.frame.width, height: estimatedSize.height)
    }
}
