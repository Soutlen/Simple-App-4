//
//  MarketViewController.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/14/25.
//

import UIKit

protocol MarketViewProtocol: AnyObject {
    /// Показывает пользователю алерт с сообщением об ошибке.
    /// - Parameter message: Текст ошибки для отображения.
    func showError(_ message: String)
    var collectionView: UICollectionView { get }
}

final class MarketViewController: UIViewController, MarketViewProtocol {
    var presenter: MarketViewPresenterProtocol!
    let refreshControl = UIRefreshControl()

    // MARK: - UI Components
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 80)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CoinCell.self, forCellWithReuseIdentifier: "CoinCell")
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Рынок"
        setupUI()
        presenter.fetchMoreCoinsIfNeeded()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .clear
        let topColor = UIColor(red: 29/255, green: 38/255, blue: 96/255, alpha: 1.0)
        let bottomColor = UIColor(red: 20/255, green: 25/255, blue: 50/255, alpha: 1.0)
        
        view.applyGradient(
                colors: [topColor, bottomColor],
                startPoint: CGPoint(x: 0.5, y: 0),
                endPoint: CGPoint(x: 0.5, y: 1)
            )
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MarketViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.coins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCell", for: indexPath) as? CoinCell else {
            return UICollectionViewCell()
        }
        let coin = presenter.coins[indexPath.item]
        cell.configure(with: coin)
        return cell
    }
}

extension MarketViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == presenter.coins.count - 5 {
            presenter.fetchMoreCoinsIfNeeded()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = presenter.coins[indexPath.item]
        let vc = Builder.createDetailViewController(with: item)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -Confirm protocol
extension MarketViewController {
    func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "Повторить",
            style: .default,
            handler: { [weak self] _ in
                self?.presenter.retryFetch()
            }
        ))
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .cancel
        ))
        
        present(alert, animated: true)
    }
}
