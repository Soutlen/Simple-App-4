//
//  SettingsPresenter.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/19/25.
//

import UIKit

protocol SettingsPresenterProtocol: AnyObject {
    var sections: [[SettingsOption]] { get }
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
}

/// Presenter для модуля настроек. Обрабатывает логику, связанную с изменением и сохранением настроек приложения.
final class SettingsPresenter: SettingsPresenterProtocol {
    
    weak var view: SettingsViewProtocol?
    var sections = [[SettingsOption]]()
    
    init(view: SettingsViewProtocol?) {
        self.view = view
    }
    
    private func configureModels() {
        let section1 = [
            SettingsOption(
                title: "Как пользоваться",
                icon: UIImage(systemName: "book.fill"),
                iconBackgroundColor: .systemBlue) { print("Tapped: Как пользоваться") },
            
            SettingsOption(
                title: "Время использования",
                icon: UIImage(systemName: "clock.fill"),
                iconBackgroundColor: .systemPurple) { print("Tapped: Время использования") },
            
            SettingsOption(
                title: "Установить лимит",
                icon: UIImage(systemName: "timer"),
                iconBackgroundColor: .systemOrange) { print("Tapped: Установить лимит") }
        ]
        
        let section2 = [
            SettingsOption(
                title: "PIN-код",
                icon: UIImage(systemName: "lock.fill"),
                iconBackgroundColor: .systemRed) { print("Tapped: PIN-код") },
            
            SettingsOption(
                title: "Звуки",
                icon: UIImage(systemName: "speaker.wave.2.fill"),
                iconBackgroundColor: .systemGreen) { print("Tapped: Звуки") }
        ]
        
        let section3 = [
            SettingsOption(
                title: "Восстановить покупки",
                icon: UIImage(systemName: "arrow.clockwise"),
                iconBackgroundColor: .systemGray) { print("Tapped: Восстановить покупки") },
            
            SettingsOption(
                title: "Поддержка",
                icon: UIImage(systemName: "questionmark.circle.fill"),
                iconBackgroundColor: .systemTeal) { print("Tapped: Поддержка") }
        ]
        
        let section4 = [
            SettingsOption(
                title: "Политика конфиденциальности",
                icon: UIImage(systemName: "doc.text.fill"),
                iconBackgroundColor: .systemIndigo) { print("Tapped: Политика конфиденциальности") },
            
            SettingsOption(
                title: "Условия использования",
                icon: UIImage(systemName: "doc.fill"),
                iconBackgroundColor: .systemIndigo) { print("Tapped: Условия использования") }
        ]
        
        let section5 = [
            SettingsOption(
                title: "Оценить приложение",
                icon: UIImage(systemName: "star.fill"),
                iconBackgroundColor: .systemYellow) { print("Tapped: Оценить приложение") },
            
            SettingsOption(
                title: "Поделиться приложением",
                icon: UIImage(systemName: "square.and.arrow.up.fill"),
                iconBackgroundColor: .systemBlue) { print("Tapped: Поделиться приложением") }
        ]
        
        sections = [section1, section2, section3, section4, section5]
        view?.reloadData()
    }
} 

//MARK: -Confirm protocol
extension SettingsPresenter {
    func viewDidLoad() {
        configureModels()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let model = sections[indexPath.section][indexPath.row]
        model.handler()
    }
}
