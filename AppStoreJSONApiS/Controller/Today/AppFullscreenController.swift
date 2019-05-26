//
//  AppFullscreenController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 01/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class AppFullscreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        btn.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return btn
    }()
    
    lazy var tableView: UITableView = {
       let tv = UITableView(frame: .zero, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        tv.layer.cornerRadius = 16
        tv.separatorStyle = .none
        tv.contentInsetAdjustmentBehavior = .never
        tv.allowsSelection = false
        tv.register(AppFullscreenDescriptionCell.self, forCellReuseIdentifier: cellId)
        tv.register(AppFullscreenHeaderCell.self, forCellReuseIdentifier: headerCellId)
        return tv
    }()
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
        } else {
            //self.floatingContainerView.isHidden = false
        }

        if scrollView.contentOffset.y == 0 {
            scrollView.isScrollEnabled = true
            //self.floatingContainerView.isHidden = true
        }

        let translationY = -90 - UIApplication.shared.statusBarFrame.height
        let transform = scrollView.contentOffset.y > 100 ? CGAffineTransform(translationX: 0, y: translationY) : .identity

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: { [weak self] in

            self?.floatingContainerView.transform = transform

        })

    }
    
    var todayItem: TodayItem?
    
    var didSelectHandler: (() -> ())?
    
    let headerCellId = "headerCellId"
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.contentInset = .init(top: 0, left: 0, bottom: UIApplication.shared.statusBarFrame.height, right: 0)
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
        let height = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
        showWidget()
        
        
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellId) as! AppFullscreenHeaderCell
            cell.todayCell.todayItem = todayItem
            cell.layer.cornerRadius = 0
            cell.clipsToBounds = true
            cell.todayCell.backgroundView = nil
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AppFullscreenDescriptionCell
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
        return TodayCollectionController.cellHeight
        } else {
            return UITableView.automaticDimension
        }
        
    }

    let floatingContainerView = UIView()
    
    fileprivate func showWidget() {
        
        floatingContainerView.layer.cornerRadius = 16
        floatingContainerView.clipsToBounds = true
        tableView.addSubview(floatingContainerView)
        floatingContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: -90, right: 16), size: .init(width: 0, height: 90))
        let blurredVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingContainerView.addSubview(blurredVisualEffectView)
        blurredVisualEffectView.fillSuperview()
        
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.image = todayItem?.image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.constrainHeight(constant: 68)
        imageView.constrainWidth(constant: 68)
        
        let label = UILabel(text: todayItem?.title ?? "", font: .boldSystemFont(ofSize: 16))
        let getBtn = UIButton(title: "GET")
        getBtn.setTitleColor(.white, for: .normal)
        getBtn.backgroundColor = .gray
        getBtn.layer.cornerRadius = 16
        getBtn.constrainHeight(constant: 32)
        getBtn.constrainWidth(constant: 80)
        
        let widgetView = UIStackView(arrangedSubviews: [imageView, label, getBtn])
        widgetView.alignment = .center
        floatingContainerView.addSubview(widgetView)
        widgetView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        
    }
    
    @objc fileprivate func handleClose(button: UIButton) {
        button.isHidden = true
        didSelectHandler?()
    }

}
