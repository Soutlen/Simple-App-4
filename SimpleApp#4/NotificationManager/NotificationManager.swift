//
//  FavoritesManager.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/22/25.
//

import Foundation

extension Notification.Name {
    static let favoritesDidUpdate = Notification.Name("favoritesDidUpdate")
    
    static let goToReg = Notification.Name("goToReg")
    
    static let goToAuth = Notification.Name("goToAuth")
    
    static let setRoot = Notification.Name("setRoot")
}

final class NotificationManager {
    static let shared = NotificationManager()
    
    private var favoriteCoins: [Coin] = []
    
    var favorites: [Coin] {
        return favoriteCoins
    }
    
    private init() {}
    
    func addFavorite(_ coin: Coin) {
        guard !favoriteCoins.contains(where: { $0.id == coin.id }) else {
            return
        }
        favoriteCoins.append(coin)
        
        NotificationCenter.default.post(name: .favoritesDidUpdate, object: nil)
    }
}
