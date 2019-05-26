//
//  TodayCollectionController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 01/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class TodayCollectionController: BaseListController, UIGestureRecognizerDelegate {
    
    let headerId = "headerId"
    
    let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.color = .gray
        ai.hidesWhenStopped = true
        ai.startAnimating()
        ai.isHidden = false
        return ai
    }()
    
    let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    var items = [TodayItem]()
    
    var topGames: Feed?
    var topGrossing: Feed?
    let isSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.9555082917, green: 0.9493837953, blue: 0.9556146264, alpha: 1)
        navigationController?.isNavigationBarHidden = true
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.normal.rawValue)
        collectionView.register(TodayMultipleViewCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        collectionView.register(TodayHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    fileprivate func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, err) in
            //check for error
            dispatchGroup.leave()
            self.topGames = appGroup?.feed
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, err) in
            dispatchGroup.leave()
            self.topGrossing = appGroup?.feed
        }
        
        dispatchGroup.notify(queue: .main) {
            
            self.items = [
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way", backgroundColor: .white, cellType: .normal, apps: []),
                TodayItem.init(category: "DAILY LIST", title: self.topGames?.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way", backgroundColor: .white, cellType: .multiple, apps: self.topGames?.results ?? []),
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how oto travel without packing everything", backgroundColor: #colorLiteral(red: 0.9844933152, green: 0.9654843211, blue: 0.7258060575, alpha: 1), cellType: .normal, apps: []),
                TodayItem.init(category: "DAILY LIST", title: self.topGrossing?.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way", backgroundColor: .white, cellType: .multiple, apps: self.topGrossing?.results ?? []),
            ]
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 80)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       let cellId = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        cell.layer.cornerRadius = 12
        
        (cell as? TodayMultipleViewCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
         
        return cell
    }
    
    @objc fileprivate func handleMultipleAppsTap(gesture: UITapGestureRecognizer) {
        
        let gestureCollectionView = gesture.view
        
        //figure out which cell we are clicking into
        var superview = gestureCollectionView?.superview
        
        while superview != nil {
            if let cell = superview as? TodayMultipleViewCell {
                guard let indexPath = collectionView.indexPath(for: cell) else {return}
                let apps = self.items[indexPath.item].apps
                
                let fullController = TodayMultipleAppsController(mode: .fullscreen)
                fullController.apps = apps
                present(BackEnabledNavigationController(rootViewController: fullController), animated: true)
                return
                
            }
            superview = superview?.superview
        }
    }
    
    static let cellHeight: CGFloat = 500
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayCollectionController.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 0, bottom: 32, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch items[indexPath.item].cellType {
        case .multiple:
            showDailyListFullScreen(indexPath)
        default:
            showSingleAppFullscreen(indexPath: indexPath)
        }
    }
    
    var startingFrame: CGRect?
    var appFullscreenController: AppFullscreenController!
    var appFullscreenConstraints: AnchoredConstraints?
    
    fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
        let fullMultipleAppsController = TodayMultipleAppsController(mode: .fullscreen)
        fullMultipleAppsController.apps = items[indexPath.item].apps
        present(BackEnabledNavigationController(rootViewController: fullMultipleAppsController), animated: true)
    }
    
    fileprivate func setupSingleAppFullscreenController(indexPath: IndexPath) {
        let appFullscreenController = AppFullscreenController()
         appFullscreenController.todayItem = items[indexPath.row]
        appFullscreenController.didSelectHandler = {
            self.handleRemoveView()
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(scrollDismissal))
        appFullscreenController.view.addGestureRecognizer(panGesture)
        panGesture.delegate = self
        
        self.appFullscreenController = appFullscreenController
    }
    
    var appFullscreenBeginOffset: CGFloat = 0
    
    @objc fileprivate func scrollDismissal(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            appFullscreenBeginOffset = appFullscreenController.tableView.contentOffset.y
        }
        
        if appFullscreenController.tableView.contentOffset.y > 0 {
            return
        }
        
        let translationY = gesture.translation(in: appFullscreenController.view).y
      
        if gesture.state == .changed {
            if translationY > 0 {
                let trueOffset = translationY - appFullscreenBeginOffset
                print(trueOffset)
                var scale = 1 - trueOffset / 1000
                scale = min(1, scale)
                scale = max(0.5, scale)
            appFullscreenController.view.transform = .init(scaleX: scale, y: scale)
            }
        } else if gesture.state == .ended {
            if translationY > 0 {
            appFullscreenController.closeButton.isHidden = true
            handleRemoveView()
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    fileprivate func startingCellFrame(_ indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) else {return}
        
        //absolute coordinates of cell
        guard let frame = selectedCell.superview?.convert(selectedCell.frame, to: nil) else {return}
        startingFrame = frame
    }
    
    fileprivate func setupAppFullscreenStartingPosition(_ indexPath: IndexPath) {
        view.addSubview(appFullscreenController.view)
        addChild(appFullscreenController)
        
        startingCellFrame(indexPath)
        
        collectionView.isUserInteractionEnabled = false
        
        guard let startingFrame = self.startingFrame else {return}
        
        appFullscreenConstraints = appFullscreenController.view.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))

        self.view.layoutIfNeeded()
        
    }
    
    fileprivate func appFullscreenPresentWithAnimation() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            guard let keyWindow = UIApplication.shared.keyWindow else {return}
           
            self.appFullscreenConstraints?.top?.constant = 0
            self.appFullscreenConstraints?.leading?.constant = 0
            self.appFullscreenConstraints?.width?.constant = keyWindow.frame.width
            self.appFullscreenConstraints?.height?.constant = keyWindow.frame.height
            
            guard let headerCell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else {return}
            headerCell.todayCell.topConstraint.constant = 44
            headerCell.layoutIfNeeded()
            
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: nil)
    }
    
    fileprivate func showSingleAppFullscreen(indexPath: IndexPath) {
        view.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        // #1
        setupSingleAppFullscreenController(indexPath: indexPath)
        
        //#2 setup fullscreen in its starting position
        setupAppFullscreenStartingPosition(indexPath)
        
        //#3 present fullscreen controller with animation
        appFullscreenPresentWithAnimation()
    }
    
    @objc fileprivate func handleRemoveView() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.appFullscreenController.view.transform = .identity
            self.blurVisualEffectView.removeFromSuperview()
            
            self.appFullscreenController.tableView.contentOffset = .zero
//            gesture.view?.frame = self.startingFrame ?? .zero
            guard let startingFrame = self.startingFrame else {return}
        
            self.appFullscreenConstraints?.top?.constant = startingFrame.origin.y
            self.appFullscreenConstraints?.leading?.constant = startingFrame.origin.x
            self.appFullscreenConstraints?.width?.constant = startingFrame.width
            self.appFullscreenConstraints?.height?.constant = startingFrame.height
            
            self.tabBarController?.tabBar.transform = .identity
            guard let headerCell = self.appFullscreenController.tableView.cellForRow(at: [0, 0]) as? AppFullscreenHeaderCell else {return}
            headerCell.todayCell.topConstraint.constant = 24
             self.collectionView.isUserInteractionEnabled = true
            self.view.layoutIfNeeded()
            
        }) { (_) in
            self.appFullscreenController.view.removeFromSuperview()
            self.appFullscreenController.removeFromParent()
        }
    }
    
}
