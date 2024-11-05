//
//  AppDelegate.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var networkMonitor: NetworkMonitor?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        networkMonitor = NetworkMonitor()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        configureRootViewController()
        
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        
        networkMonitor?.startMonitoring()
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        networkMonitor?.stopMonitoring()
    }
    
    private func configureRootViewController() {
        // MARK: - ViewControllers
        let homeViewController = HomeViewController()
        let favoritesViewController = FavoritesViewController()
        
        // MARK: - NavigationControllers
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Top Rated", image: UIImage(systemName: "film"), tag: 0)

        let favoritesNavigationController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        
        // MARK: - TabBarController
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeNavigationController, favoritesNavigationController]
        tabBarController.configureTabBarAppearance()
        
        
        // MARK: - WindowConfig
        window?.rootViewController = tabBarController
    }
}

