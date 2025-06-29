//
//  TracingViewController.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/22/25.
//

import UIKit

protocol TracingViewProtocol: AnyObject {
    /// Обновляет `UICollectionView`, чтобы отобразить актуальный список избранных монет.
    func reloadData()
}

/// Контроллер, отображающий список избранных криптовалют.
final class TracingViewController: UIViewController {
    
    var presenter: TracingViewPresenterProtocol!
    private var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Отслеживание"
        setupUI()
        setupCollectionView()
        presenter.viewDidLoad()
    }
    
    // MARK: - UI Setup
    func setupUI() {
        view.backgroundColor = .clear
        
        let topColor = UIColor(red: 29/255, green: 38/255, blue: 96/255, alpha: 1.0)
        let bottomColor = UIColor(red: 20/255, green: 25/255, blue: 50/255, alpha: 1.0)
        
        view.applyGradient(
                colors: [topColor, bottomColor],
                startPoint: CGPoint(x: 0.5, y: 0),
                endPoint: CGPoint(x: 0.5, y: 1)
            )
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 2 - 24, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavoriteCoinCell.self, forCellWithReuseIdentifier: FavoriteCoinCell.identifier)
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension TracingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.favoriteCoins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCoinCell.identifier, for: indexPath) as? FavoriteCoinCell else {
            return UICollectionViewCell()
        }
        let coin = presenter.favoriteCoins[indexPath.item]
        cell.configure(with: coin)
        return cell
    }
}

// -MARK: - ConfirmProtocol
extension TracingViewController: TracingViewProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
}

