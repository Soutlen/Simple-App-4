//
//  NetworkManager.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/14/25.
//

import UIKit

/// NetworkError - представляет собой обработчиком ошибок для разных ситуаций.
///
/// massage - отрабатывает в паре с Alert для уточнения ошибки на определенной стадии.
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
    case networkingError(Error)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "Неверный URL"
        case .noData:
            return "Нет данных"
        case .decodingError:
            return "Ошибка декодирования данных"
        case .serverError(let message):
            return "Ошибка сервера: \(message)"
        case .networkingError(let error):
            return "Ошибка сети: \(error.localizedDescription)"
        }
    }
}

protocol NetworkManagerProtocol {
    /// Загружает список криптовалют с сервера с поддержкой пагинации.
    /// - Parameters:
    ///   - page: Номер страницы для загрузки.
    ///   - completion: Замыкание, которое будет вызвано по завершении запроса. Возвращает либо массив `[Coin]`, либо `NetworkError`.
    func fetchCoinsList(page: Int, completion: @escaping (Result<[Coin], NetworkError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    /// Реализация метода для загрузки списка криптовалют.
    ///
    /// Создает URL-запрос к API CoinGecko, включая параметры для валюты (`usd`), количества элементов на странице (`per_page`) и номера страницы (`page`).
    /// Выполняет запрос, обрабатывает ответ и декодирует его в массив объектов `Coin`.
    func fetchCoinsList(page: Int, completion: @escaping (Result<[Coin], NetworkError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.coingecko.com"
        urlComponents.path = "/api/v3/coins/markets"
        urlComponents.queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "per_page", value: "50"),
            URLQueryItem(name: "page", value: String(page))
        ]
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(.networkingError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                completion(.success(coins))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
