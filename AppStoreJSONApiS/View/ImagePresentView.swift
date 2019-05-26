//
//  ImagePresentView.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 13/04/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit
import SDWebImage

class ImagePresentView: UIView {
    
    let screenShotImageView: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var closeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setBackgroundImage(UIImage(named: "close_button"), for: .normal)
        btn.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return btn
    }()
    
    @objc func closeView() {
        let keyWindow = UIApplication.shared.keyWindow
        guard let subviews = keyWindow?.subviews else {return}
        for view in subviews {
            if let imagePresentView = view as? ImagePresentView {
                UIView.animate(withDuration: 0.3, animations: {
                   imagePresentView.removeFromSuperview()
                    imagePresentView.layoutIfNeeded()
                }) { (_) in
                    
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(screenShotUrl: String) {
        screenShotImageView.sd_setImage(with: URL(string: screenShotUrl), completed: nil)
    }
    
    func setupViews() {
        
        addSubview(screenShotImageView)
        addSubview(closeBtn)
        screenShotImageView.fillSuperview()
        closeBtn.anchor(top: screenShotImageView.topAnchor, leading: nil, bottom: nil, trailing: screenShotImageView.trailingAnchor, padding: UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 16), size: CGSize(width: 40, height: 40))
        self.fillSuperview()
        self.layoutIfNeeded()
        
    }
}
