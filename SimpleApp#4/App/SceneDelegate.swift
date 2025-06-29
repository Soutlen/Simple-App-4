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
        self.window?.rootViewController = Builder.createAuthViewController()
        self.window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setRoot), name: .setRoot, object: nil)
    }
    
    @objc func setRoot(nt: Notification) {
        guard let userInfo = nt.userInfo,
              let screen = userInfo["screen"] as? String else {
            print("Ошибка: не передан тип экрана")
            return
        }
        switch screen {
        case "reg":
            self.window?.rootViewController = Builder.createRegViewController()
        case "auth":
            self.window?.rootViewController = Builder.createAuthViewController()
        default:
            print("Ошибка: неизвестный экран")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

