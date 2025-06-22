//
//  SceneDelegate.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/14/25.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController = Builder.createTabBarController()
        self.window?.makeKeyAndVisible()
    }
}

