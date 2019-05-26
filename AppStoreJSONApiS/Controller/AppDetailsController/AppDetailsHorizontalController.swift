//
//  AppDetailsHorizontalController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 26/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class AppDetailsHorizontalController: HorizontalSnappingController {
    
    var app: Result? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let cellId = "cellId"
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppDetailsScreenshotsImageCell
        cell.screenShotUrl = app?.screenshotUrls?[indexPath.item] ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width + view.frame.width / 4) / 2, height: view.frame.height
        )
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let keyWindow = UIApplication.shared.keyWindow
        let view = ImagePresentView()
        view.contentMode = .redraw
        view.setImage(screenShotUrl: app?.screenshotUrls?[indexPath.item] ?? "")
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            keyWindow?.addSubview(view)
            view.setupViews()
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailsScreenshotsImageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}
