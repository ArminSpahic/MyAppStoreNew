//
//  TodayMultipleAppsController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 03/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class TodayMultipleAppsController: BaseListController {
    
    let closeBtn: UIButton = {
       let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return btn
    }()

    var apps = [AppResult]()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellId)
        
        if mode == .fullscreen {
            setupCloseBtn()
            navigationController?.isNavigationBarHidden = true
        } else {
            collectionView.isScrollEnabled = false
        }
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    fileprivate func setupCloseBtn() {
        view.addSubview(closeBtn)
        closeBtn.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16), size: .init(width: 44, height: 44))
    }
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullscreen {
            return apps.count
        }
        return min(4,apps.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MultipleAppCell
        cell.appResult = apps[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width:CGFloat = collectionView.frame.width
        let height: CGFloat = 68//(view.frame.height - 3 * spacing) / 4
        
        if mode == .fullscreen {
            width = collectionView.frame.width - 48
        }
        
        return .init(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let item = apps[indexPath.item]
        
        let detailsAppController = AppDetailsController(appId: item.id ?? "")
        navigationController?.pushViewController(detailsAppController, animated: true)
        
        
    }
    
    fileprivate let spacing: CGFloat = 16
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 24, bottom: 12, right: 24)
    }
    
    fileprivate  var mode: Mode
    
    enum Mode {
        case small, fullscreen
    }
    
     init(mode: Mode) {
        self.mode = mode
        super.init()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
