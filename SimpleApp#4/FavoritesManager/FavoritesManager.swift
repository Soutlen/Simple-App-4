//
//  FavoritesManager.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/22/25.
//

import Foundation

extension Notification.Name {
    static let favoritesDidUpdate = Notification.Name("favoritesDidUpdate")
}

final class FavoritesManager {
    static let shared = FavoritesManager()
    
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
