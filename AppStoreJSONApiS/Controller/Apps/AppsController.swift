//
//  AppsController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 15/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class AppsController: BaseListController {
    
    let activityIndicator: UIActivityIndicatorView = {
       let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.color = .gray
        ai.hidesWhenStopped = true
        ai.startAnimating()
        ai.isHidden = false
        return ai
    }()
    
    let cellId = "cellId"
    let headerId = "headerId"
    var editorsChoiceGroup: AppGroup?
    var groups = [AppGroup]()
    var socialApps = [SocialApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        setupCollectionView()
        fetchData()
    
    }

    fileprivate func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        var gamesGroup: AppGroup?
        var topGrossingGames: AppGroup?
        var topFree: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (socialApps, err) in
            socialApps?.forEach({self.socialApps.append($0)})
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, err) in
            dispatchGroup.leave()
            gamesGroup = appGroup
            //            self.editorsChoiceGroup?.feed?.results.forEach({print($0.name)})
        }
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, err) in
            dispatchGroup.leave()
            topGrossingGames = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopFree { (appGroup, err) in
            dispatchGroup.leave()
            topFree = appGroup
        }
        
        dispatchGroup.notify(queue: .main) {
            guard let games = gamesGroup else {return}
            guard let topGrossing = topGrossingGames else {return}
            guard let topFreeGames = topFree else {return}
            
            self.groups.append(games)
            self.groups.append(topGrossing)
            self.groups.append(topFreeGames)
            
            self.activityIndicator.stopAnimating()
            
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.backgroundColor = .white
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        header.appHorizontalController.socialApps = socialApps
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 300)
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        cell.titleLabel.text = groups[indexPath.item].feed?.title
        cell.appsHorizontalViewController.feed = groups[indexPath.item].feed
        cell.appsHorizontalViewController.didSelectHandler = {[weak self] app in
            
            let controller = AppDetailsController(appId: app.id ?? "")
            controller.navigationItem.title = app.name
            self?.navigationController?.pushViewController(controller, animated: true)
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width , height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
}
