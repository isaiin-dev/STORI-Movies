//
//  UIView+Extensions.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//

import UIKit

extension UIView {
    func addSubViews(views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func setDefaultShadow() {
        addShadow(
            offset: CGSize(width: 0, height: 6),
            color: .black,
            radius: 9,
            opacity: 0.3)
    }
    
    func setCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func addTopGradientLayer(height: CGFloat = 100.0) {
        self.layer.sublayers?.filter { $0.name == "TopGradientLayer" }.forEach { $0.removeFromSuperlayer() }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "TopGradientLayer"
        gradientLayer.frame = CGRect(x: 0, y: 50, width: self.bounds.width, height: height)
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        
        self.layer.addSublayer(gradientLayer)
        
        gradientLayer.frame = CGRect(x: 0, y: 50, width: self.bounds.width, height: height)
    }
}
