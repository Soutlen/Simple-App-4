//
//  UIButton + Factory.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 7/9/25.
//

import UIKit

func makeButton(title: String,
                backColor: UIColor,
                isEnabled: Bool,
                action: @escaping (UIAction) -> Void) -> UIButton {
    let buttonAction = UIAction(handler: action)
    let button = UIButton(primaryAction: buttonAction)
    button.setTitle(title, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.backgroundColor = backColor
    button.layer.cornerRadius = 20
    button.isEnabled = isEnabled
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
}
