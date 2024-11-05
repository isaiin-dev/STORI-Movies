//
//  UIViewController+UIViewController.swift
//  StoriAppTest
//
//  Created by Alejandro Isai Acosta Martinez on 04/11/24.
//

import UIKit

extension UIViewController {
    func configureNavigationBarAppearance(title: String, prefersLargeTitles: Bool = true) {
        self.title = title
        
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.lightMist
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.deepTeal,
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.deepTeal,
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.tintColor = .darkSlate
    }
    
    func showNotification(with data: CustomNotification.NotificationData) {
        CustomNotification(data: data, parentViewController: self).show()
    }
    
    func applyInterfaceColors(from image: UIImage) {
        // Extrae los colores dominantes de la imagen
        let colors = extractDominantColors(from: image)
        
        // Configura la apariencia de la barra de navegación
        if let navigationController = self.navigationController {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = colors.primaryColor // Fondo de la barra de navegación

            // Configura los atributos del título y el botón de retroceso
            appearance.titleTextAttributes = [
                .foregroundColor: colors.secondaryColor,
                .font: UIFont.systemFont(ofSize: 17, weight: .semibold)
            ]
            appearance.largeTitleTextAttributes = [
                .foregroundColor: colors.secondaryColor,
                .font: UIFont.systemFont(ofSize: 34, weight: .bold)
            ]
            
            // Aplica la apariencia a la barra de navegación
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
            navigationController.navigationBar.tintColor = colors.accentColor // Color del botón de retroceso
        }
        
        // Configura la apariencia de la barra de pestañas
        if let tabBarController = self.tabBarController {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = colors.primaryColor // Fondo de la barra de pestañas
            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = colors.secondaryColor
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: colors.secondaryColor]
            tabBarAppearance.stackedLayoutAppearance.selected.iconColor = colors.accentColor
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: colors.accentColor]
            
            // Aplica la apariencia a la barra de pestañas
            tabBarController.tabBar.standardAppearance = tabBarAppearance
            if #available(iOS 15.0, *) {
                tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
            }
        }
    }

    private func extractDominantColors(from image: UIImage) -> (primaryColor: UIColor, secondaryColor: UIColor, accentColor: UIColor) {
        guard let cgImage = image.cgImage else {
            return (primaryColor: UIColor.lightMist, secondaryColor: UIColor.darkSlate, accentColor: UIColor.tealGray)
        }

        let width = 10
        let height = 10
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var pixelData = [UInt8](repeating: 0, count: width * height * 4)
        let context = CGContext(data: &pixelData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        var redTotal = 0, greenTotal = 0, blueTotal = 0
        for x in 0..<width {
            for y in 0..<height {
                let index = 4 * (y * width + x)
                redTotal += Int(pixelData[index])
                greenTotal += Int(pixelData[index + 1])
                blueTotal += Int(pixelData[index + 2])
            }
        }

        let pixelCount = width * height
        let avgRed = CGFloat(redTotal / pixelCount) / 255.0
        let avgGreen = CGFloat(greenTotal / pixelCount) / 255.0
        let avgBlue = CGFloat(blueTotal / pixelCount) / 255.0

        let primaryColor = UIColor(red: avgRed, green: avgGreen, blue: avgBlue, alpha: 1.0)
        let secondaryColor = primaryColor.withAlphaComponent(0.7) // Ajusta como secundario
        let accentColor = primaryColor.withAlphaComponent(0.5) // Ajusta como acento

        return (primaryColor: primaryColor, secondaryColor: secondaryColor, accentColor: accentColor)
    }

}
