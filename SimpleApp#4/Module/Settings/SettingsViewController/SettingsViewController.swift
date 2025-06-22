//
//  SettingsViewController.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/19/25.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    func reloadData()
    var tableView: UITableView { get }
}

/// Контроллер, отображающий экран настроек приложения.
final class SettingsViewController: UIViewController, SettingsViewProtocol {

    var presenter: SettingsPresenterProtocol!
    
    // MARK: - UI Components
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
        setupUI()
        presenter.viewDidLoad()
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
    
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier, for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }
        
        let model = presenter.sections[indexPath.section][indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
} 
