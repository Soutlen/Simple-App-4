//
//  TabBar.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/14/25.
//

import UIKit

final class TabView: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
        // Настройка внешнего вида TabBar
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .systemBackground
    }
    
    /// Инициализирует и настраивает все вкладки (табы) приложения.
    ///
    /// Создает контроллеры для каждой вкладки с помощью `Builder`,
    /// задает им заголовки и иконки, а затем добавляет их в `viewControllers`.
    private func setupTabBar() {
        let marketVC = Builder.createMarketViewController()
        let settingsVC = Builder.createSettingsViewController()
        let tracingVC = Builder.createTracingViewController()
        
        marketVC.tabBarItem = UITabBarItem(
            title: "Рынок",
            image: UIImage(systemName: "chart.line.uptrend.xyaxis"),
            selectedImage: UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")
        )
        
        settingsVC.tabBarItem = UITabBarItem(
            title: "Настройки",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        
        tracingVC.tabBarItem = UITabBarItem(
                title: "Отслеживание",
                image: UIImage(systemName: "star"),
                selectedImage: UIImage(systemName: "star.fill")
            )
        
        viewControllers = [marketVC, tracingVC, settingsVC]
    }
}
