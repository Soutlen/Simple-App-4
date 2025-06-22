//
//  Bulder.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/14/25.
//

import UIKit

/// Статический класс-сборщик, отвечающий за создание и конфигурацию MVP модулей.
final class Builder {
    private init() {}

    
    /// Создает и конфигурирует главный TabBarController приложения.
    /// - Returns: Готовый к отображению `UITabBarController`.
    static func createTabBarController() -> UIViewController {
        return TabView()
    }

    /// Собирает модуль "Рынок" (Market).
    ///
    /// Создает `MarketViewController` и `MarketViewPresenter`, связывает их друг с другом и внедряет `NetworkManager` в качестве зависимости.
    /// Оборачивает контроллер в `UINavigationController` с настроенным внешним видом.
    /// - Returns: `UINavigationController` с `MarketViewController` в качестве корневого экрана.
    static func createMarketViewController() -> UIViewController {
        let networkManager = NetworkManager()
        let viewController = MarketViewController()
        let presenter = MarketViewPresenter(view: viewController, network: networkManager)
        viewController.presenter = presenter
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }

    /// Собирает модуль "Настройки" (Settings).
    ///
    /// Создает `SettingsViewController` и `SettingsPresenter`, связывая их.
    /// - Returns: `UINavigationController` с `SettingsViewController` в качестве корневого экрана.
    static func createSettingsViewController() -> UIViewController {
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(view: viewController)
        viewController.presenter = presenter
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
    
    static func createDetailViewController(with coin: Coin) -> UIViewController {
        let viewController = DetailViewController()
        let presenter = DetailPresenter(view: viewController, coin: coin)
        viewController.presenter = presenter
        
        return viewController
    }
    
    /// Собирает модуль детальной информации о монете (Detail).
    /// - Parameter coin: Объект `Coin`, данные которого нужно отобразить.
    /// - Returns: Готовый `DetailViewController`.
    static func createTracingViewController() -> UIViewController {
        let viewController = TracingViewController()
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
