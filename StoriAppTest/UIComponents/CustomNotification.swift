//
//  Untitled.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//

import UIKit

@available(iOS 13.0, *)
class CustomNotification: UIView {
    // MARK: - Helpers
    
    enum NotificationType {
        case Success
        case Error
        case Warning
        case Info
    }
    
    struct NotificationData {
        let title: String
        let type: NotificationType
    }
    
    // MARK: - Properties
    
    private var data: NotificationData?
    
    private var parentViewController: UIViewController?
    
    var timer: Timer?
    
    // MARK: - Subviews
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white.withAlphaComponent(0.5)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var closeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "xmark.circle"))
        imageView.contentMode = .center
        imageView.tintColor = .white.withAlphaComponent(0.5)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeImageViewActionHandler))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Initialization
    
    init(data: NotificationData, parentViewController: UIViewController) {
        super.init(frame: .zero)
        self.parentViewController = parentViewController
        self.data = data
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        stopTimer()
    }
    
    // MARK: - SetupView
    
    private func setup() {
        self.addSubViews(
            views:
                iconImageView,
                titleLabel,
                closeImageView)
        
        guard let data = self.data else { return }
        
        self.titleLabel.text = data.title
        
        switch data.type {
        case .Success:
            self.backgroundColor = .systemGreen
            self.iconImageView.image = UIImage(systemName: "checkmark.shield.fill")
        case .Error:
            self.backgroundColor = .systemRed
            self.iconImageView.image = UIImage(systemName: "xmark.shield.fill")
        case .Warning:
            self.backgroundColor = .systemYellow
            self.iconImageView.image = UIImage(systemName: "exclamationmark.shield.fill")
        case .Info:
            self.backgroundColor = .systemGray
            self.iconImageView.image = UIImage(systemName: "bolt.shield.fill")
        }
        
        setDefaultShadow()
        setCornerRadius(radius: 8)
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0
    }
    
    // MARK: - SetupConstraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            closeImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            closeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            closeImageView.widthAnchor.constraint(equalToConstant: 40),
            closeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 4),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: closeImageView.leadingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    // MARK: - Actions
    
    @objc func closeImageViewActionHandler() {
        self.hide()
    }
    
    func show() {
        guard let parentView = self.parentViewController?.view else { return }
        parentView.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: 0),
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8),
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -8),
            heightAnchor.constraint(equalToConstant: 48)
        ])
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        } completion: { finished in
            if finished {
                self.startTimer()
            }
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        } completion: { finished in
            if finished {
                self.removeFromSuperview()
            }
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(performAction), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func performAction() {
        self.hide()
    }
}
