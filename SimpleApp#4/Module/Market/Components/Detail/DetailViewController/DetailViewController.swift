//
//  DetailViewController.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/21/25.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    /// Отображает на экране всю информацию о переданной монете.
    /// - Parameter coin: Монета для отображения.
    func displayCoinDetails(coin: Coin)
}

final class DetailViewController: UIViewController, DetailViewProtocol {
    
    var presenter: DetailPresenterProtocol!
    
    // MARK: - UI Components
    private let layerView: UIView = {
        $0.backgroundColor = .gray.withAlphaComponent(0.4)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 32
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let imageMain: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let priceLabel: UILabel = {
        $0.font = .systemFont(ofSize: 32, weight: .bold)
        $0.textColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let priceChangeLabel: UILabel = {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let addFavoriteCoin: UIButton = {
        $0.setTitle("Add your favorite coin to track", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .gray.withAlphaComponent(0.6)
        $0.layer.cornerRadius = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapped()
        setupUI()
        presenter.viewDidLoad()
    }
    
    // MARK: -Action
    /// Настраивает обработчик нажатия для кнопки "Добавить в избранное".
    private func addTapped() {
        addFavoriteCoin.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    /// Метод, вызываемый при нажатии на кнопку "Добавить в избранное".
    ///
    /// Обращается к Presenter'у за текущей монетой и передает ее в `FavoritesManager`.
    @objc private func buttonTapped() {
        print("Кнопка нажата. Добавляем монету в избранное.")
        FavoritesManager.shared.addFavorite(presenter.coin)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .clear
        
        let topColor = UIColor(red: 29/255, green: 38/255, blue: 96/255, alpha: 1.0)
        let bottomColor = UIColor(red: 20/255, green: 25/255, blue: 50/255, alpha: 1.0)
        
        view.applyGradient(colors: [topColor, bottomColor],
                           startPoint: CGPoint(x: 0.5, y: 0),
                           endPoint: CGPoint(x: 0.5, y: 1))
        
        view.addSubview(layerView)
        layerView.addSubview(priceLabel)
        layerView.addSubview(priceChangeLabel)
        
        view.addSubview(imageMain)
        view.addSubview(addFavoriteCoin)
        
        NSLayoutConstraint.activate([
            imageMain.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageMain.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageMain.heightAnchor.constraint(equalToConstant: 64),
            imageMain.widthAnchor.constraint(equalToConstant: 64),
            
            layerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            layerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            layerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            layerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),
            
            priceLabel.topAnchor.constraint(equalTo: layerView.topAnchor, constant: 30),
            priceLabel.centerXAnchor.constraint(equalTo: layerView.centerXAnchor),
            
            priceChangeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            priceChangeLabel.centerXAnchor.constraint(equalTo: layerView.centerXAnchor),
            
            addFavoriteCoin.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            addFavoriteCoin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addFavoriteCoin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addFavoriteCoin.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - DetailViewProtocol
    func displayCoinDetails(coin: Coin) {
        title = coin.name
        
        imageMain.image = nil
        if let url = URL(string: coin.image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageMain.image = image
                    }
                }
            }.resume()
        }
        
        priceLabel.text = String(format: "$%.2f", coin.currentPrice)
        
        if let priceChange = coin.priceChangePercentage24h {
            priceChangeLabel.text = String(format: "%.2f%% (24h)", priceChange)
            priceChangeLabel.textColor = priceChange >= 0 ? .systemGreen : .systemRed
        } else {
            priceChangeLabel.text = "N/A"
            priceChangeLabel.textColor = .gray
        }
    }
}
