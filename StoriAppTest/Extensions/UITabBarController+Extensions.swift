//
//  UITabBarController+Extensions.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//

import UIKit

extension UITabBarController {
    func configureTabBarAppearance() {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = tabBar.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.insertSubview(blurEffectView, at: 0)
        
        tabBar.barTintColor = UIColor.white.withAlphaComponent(0.2)
        tabBar.isTranslucent = true
        
        tabBar.tintColor = .deepTeal
        tabBar.unselectedItemTintColor = .tealGray 
    }
}
