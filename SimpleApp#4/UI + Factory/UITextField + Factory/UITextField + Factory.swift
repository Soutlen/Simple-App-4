//
//  UITextField + Factory.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 7/10/25.
//

import UIKit

func makeTextField(
    placeholder: String,
    textColor: UIColor = .black,
    isSecureTextEntry: Bool = false,
    target: Any?,
    action: Selector,
    for event: UIControl.Event = .editingChanged
) -> UITextField {
    let textField = UITextField()
    textField.text = ""
    textField.placeholder = placeholder
    textField.textColor = textColor
    textField.font = .systemFont(ofSize: 14, weight: .regular)
    textField.textAlignment = .left
    textField.borderStyle = .roundedRect
    textField.keyboardType = .default
    textField.returnKeyType = .done
    textField.isSecureTextEntry = isSecureTextEntry
    textField.clipsToBounds = true
    textField.layer.cornerRadius = 15
    textField.addTarget(target, action: action, for: event)
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
}
