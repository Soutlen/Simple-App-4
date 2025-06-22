//
//  DetailPresenter.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/21/25.
//

import Foundation

protocol DetailPresenterProtocol: AnyObject {
    /// Сообщает Presenter'у, что View готово к работе.
    func viewDidLoad()
    
    /// Предоставляет доступ к модели монеты, отображаемой на экране.
    var coin: Coin { get }
}

final class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailViewProtocol?
    let coin: Coin

    init(view: DetailViewProtocol, coin: Coin) {
        self.view = view
        self.coin = coin
    }
    
    func viewDidLoad() {
        view?.displayCoinDetails(coin: coin)
    }
} 
