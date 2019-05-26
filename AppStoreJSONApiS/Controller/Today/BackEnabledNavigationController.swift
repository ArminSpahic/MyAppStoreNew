//
//  BackEnabledNavigationController.swift
//  AppStoreJSONApiS
//
//  Created by Armin Spahic on 06/05/2019.
//  Copyright © 2019 Armin Spahic. All rights reserved.
//

import UIKit

class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
}
