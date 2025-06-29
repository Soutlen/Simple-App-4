//
//  TracingPresenter.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/22/25.
//

import Foundation

protocol TracingViewPresenterProtocol: AnyObject {
    /// Предоставляет доступ к текущему списку избранных монет.
    var favoriteCoins: [Coin] { get }
    
    /// Сообщает Presenter'у, что View готово к работе.
    func viewDidLoad()
}

/// Presenter для модуля Tracing. Управляет логикой отображения избранных монет.
final class TracingPresenter: TracingViewPresenterProtocol {
    
    weak var view: TracingViewProtocol?
    private let favoritesManager = NotificationManager.shared
    
    var favoriteCoins: [Coin] {
        return favoritesManager.favorites
    }
    
    init(view: TracingViewProtocol?) {
        self.view = view
    }
    
    /// Вызывается при загрузке View.
    ///
    /// Подписывает Presenter на уведомления от `FavoritesManager` об изменениях в списке избранного.
    func viewDidLoad() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFavoritesUpdate),
            name: .favoritesDidUpdate,
            object: nil
        )
    }
    
    /// Обработчик уведомлений. Вызывается, когда список избранного изменился.
    ///
    /// Получив уведомление, дает команду View обновить себя.
    @objc private func handleFavoritesUpdate() {
        view?.reloadData()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
