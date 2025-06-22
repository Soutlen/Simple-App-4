//
//  CoinCell.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/14/25.
//

import UIKit

final class CoinCell: UICollectionViewCell {
    
    static let identifier = "CoinCell"
    
    private let hstackMain: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private let vstackLeft: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private let vstackRight: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .trailing
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private let imageMain: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        return $0
    }(UIImageView())
    
    private let nameLabel: UILabel = {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let symbolNameLabel: UILabel = {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let priceLabel: UILabel = {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let priceChangePercentage24hLabel: UILabel = {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-MARK: setup UI
    private func setupUI() {
        contentView.backgroundColor = .gray.withAlphaComponent(0.6)
        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(hstackMain)
        hstackMain.addArrangedSubview(imageMain)
        hstackMain.addArrangedSubview(vstackLeft)
        hstackMain.addArrangedSubview(vstackRight)
        
        vstackLeft.addArrangedSubview(nameLabel)
        vstackLeft.addArrangedSubview(symbolNameLabel)
        
        vstackRight.addArrangedSubview(priceLabel)
        vstackRight.addArrangedSubview(priceChangePercentage24hLabel)
        
        NSLayoutConstraint.activate([
            hstackMain.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hstackMain.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hstackMain.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageMain.widthAnchor.constraint(equalToConstant: 40),
            imageMain.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(with coin: Coin) {
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
        nameLabel.text = coin.name
        symbolNameLabel.text = coin.symbol.uppercased()
        priceLabel.text = String(format: "$%.2f", coin.currentPrice)
        
        if let priceChange = coin.priceChangePercentage24h {
            let color: UIColor = priceChange >= 0 ? .systemGreen : .systemRed
            let sign = priceChange >= 0 ? "+" : ""
            priceChangePercentage24hLabel.text = "\(sign)\(String(format: "%.2f", priceChange))%"
            priceChangePercentage24hLabel.textColor = color
        } else {
            priceChangePercentage24hLabel.text = "N/A"
            priceChangePercentage24hLabel.textColor = .black
        }
    }
}
