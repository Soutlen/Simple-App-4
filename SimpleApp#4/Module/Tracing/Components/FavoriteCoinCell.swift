//
//  FavoriteCoinCell.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/22/25.
//

import UIKit

final class FavoriteCoinCell: UICollectionViewCell {
    
    static let identifier = "FavoriteCoinCell"
    
    // MARK: - UI Components
    private let iconImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        contentView.backgroundColor = .gray.withAlphaComponent(0.4)
        contentView.layer.cornerRadius = 10
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 44),
            iconImageView.widthAnchor.constraint(equalToConstant: 44),
            
            nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with coin: Coin) {
        nameLabel.text = coin.name

        iconImageView.image = nil
        if let url = URL(string: coin.image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.iconImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
