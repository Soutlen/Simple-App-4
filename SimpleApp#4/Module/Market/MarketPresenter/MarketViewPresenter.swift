//
//  MarketPresenter.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/14/25.
//

import UIKit

protocol MarketViewPresenterProtocol {
    /// Инициирует загрузку следующей порции данных, если это необходимо.
    func fetchMoreCoinsIfNeeded()
    
    /// Предоставляет доступ к текущему списку загруженных монет.
    var coins: [Coin] { get }
    
    /// Инициирует повторную загрузку данных с самого начала (например, после ошибки).
    func retryFetch()
}

final class MarketViewPresenter: MarketViewPresenterProtocol {
    var coins: [Coin] = []
    weak var view: MarketViewProtocol?
    let network: NetworkManagerProtocol
    
    private var currentPage = 1
    private var isFetchInProgress = false
    private var hasMoreData = true
    
    init(view: MarketViewProtocol?, network: NetworkManagerProtocol) {
        self.view = view
        self.network = network
    }
    
    /// Основная логика пагинации.
    ///
    /// Проверяет, не идет ли уже загрузка и есть ли еще данные для загрузки.
    /// Если условия выполнены, обращается к `NetworkManager` за следующей страницей данных,
    /// добавляет результат к существующему списку и обновляет View.
    func fetchMoreCoinsIfNeeded() {
        guard !isFetchInProgress, hasMoreData else {
            return
        }
        
        isFetchInProgress = true
        
        network.fetchCoinsList(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let newCoins):
                    if newCoins.isEmpty {
                        self.hasMoreData = false
                    } else {
                        self.coins.append(contentsOf: newCoins)
                        self.currentPage += 1
                        self.view?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("Error fetching coins: \(error.message)")
                    self.view?.showError(error.message)
                }
                
                self.isFetchInProgress = false
            }
        }
    }
    
    /// Сбрасывает состояние пагинации и загружает данные с первой страницы.
    func retryFetch() {
        currentPage = 1
        hasMoreData = true
        coins = []
        fetchMoreCoinsIfNeeded()
    }
}
