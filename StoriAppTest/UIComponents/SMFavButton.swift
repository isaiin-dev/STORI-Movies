//
//  SMFavButton.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 05/11/24.
//

import UIKit

class FavoriteButton: UIButton {
    // MARK: - Properties
    
    var isFavorite: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupView
    
    private func setup() {
        setImage(UIImage(systemName: "heart"), for: .normal)
        tintColor = UIColor.darkSlate
        backgroundColor = UIColor.lightMist
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        //addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 44),
            heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Actions
    
    /*@objc func toggleButton() {
        animateButtonPress()
    }*/
    
    private func updateAppearance() {
        if isFavorite {
            setImage(UIImage(systemName: "heart.fill"), for: .normal)
            tintColor = UIColor.deepTeal
            backgroundColor = UIColor.mutedBlue
        } else {
            setImage(UIImage(systemName: "heart"), for: .normal)
            tintColor = UIColor.darkSlate
            backgroundColor = UIColor.lightMist
        }
    }
    
   func animateButtonPress() {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                       }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
