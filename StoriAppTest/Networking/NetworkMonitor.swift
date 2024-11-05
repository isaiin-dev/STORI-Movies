//
//  NetworkMonitor.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//

import UIKit
import Network

@available(iOS 12.0, *)
class NetworkMonitor {
    private var monitor: NWPathMonitor
    private var queue: DispatchQueue
    private var previousStatus: NWPath.Status?

    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue(label: "NetworkMonitor")
    }

    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            // Evitar notificaciones redundantes
            if self.previousStatus == path.status {
                return
            }
            self.previousStatus = path.status

            DispatchQueue.main.async {
                if path.status == .satisfied {
                    Defaults.shared.setValue(value: true, forKey: .connectedToInterntet)
                    self.getCurrentViewController()?.showNotification(with: CustomNotification.NotificationData(title: NSLocalizedString("Se restableció la conexión a internet!", comment: ""), type: .Success))
                } else {
                    Defaults.shared.setValue(value: false, forKey: .connectedToInterntet)
                    self.getCurrentViewController()?.showNotification(with: CustomNotification.NotificationData(title: NSLocalizedString("Se perdió la conexión a internet!", comment: ""), type: .Error))
                }
            }

            #if DEBUG
            print("Conexión costosa: \(path.isExpensive)")
            #endif
        }
    }

    func stopMonitoring() {
        monitor.cancel()
    }

    func getCurrentViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
                return nil
            }
            return getCurrentViewController(from: rootController)
        } else {
            guard let rootController = UIApplication.shared.keyWindow?.rootViewController else {
                return nil
            }
            return getCurrentViewController(from: rootController)
        }
    }

    private func getCurrentViewController(from vc: UIViewController) -> UIViewController {
        if let navigationController = vc as? UINavigationController,
           let lastViewController = navigationController.viewControllers.last {
            return getCurrentViewController(from: lastViewController)
        }
        if let tabBarController = vc as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return getCurrentViewController(from: selectedViewController)
        }
        if let presentedViewController = vc.presentedViewController {
            return getCurrentViewController(from: presentedViewController)
        }
        return vc
    }
}
