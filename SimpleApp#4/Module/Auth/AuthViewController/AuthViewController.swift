//
//  AuthViewController.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/26/25.
//

import UIKit

protocol AuthViewProtocol: AnyObject {
    
}

final class AuthViewController: UIViewController, AuthViewProtocol {
    
    var presenter: AuthPresenterProtocol!
    
    //MARK: -UI Components
    
    private lazy var userEmail = makeTextField(
        placeholder: "Введите email",
        textColor: .red,
        isSecureTextEntry: false,
        target: self,
        action: #selector(textFieldsChanged),
        for: .editingChanged)
    
    private lazy var userPassword = makeTextField(
        placeholder: "Введите password",
        textColor: .red,
        isSecureTextEntry: true,
        target: self,
        action: #selector(textFieldsChanged),
        for: .editingChanged)
    
    private lazy var authButton = makeButton(
        title: "Войти",
        backColor: .systemPurple,
        isEnabled: false) { _ in
        NotificationCenter.default.post(
            name: .setRoot,
            object: nil,
            userInfo: ["screen" : "tabBar"]
        )
    }
    
    private let regButton = makeButton(
        title: "Регистрация",
        backColor: .clear,
        isEnabled: true) { _ in
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        NotificationCenter.default.post(
            name: .setRoot,
            object: nil,
            userInfo: ["screen" : "reg"]
        )
    }
    
    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        
        let topColor = UIColor(red: 29/255, green: 38/255, blue: 96/255, alpha: 1.0)
        let bottomColor = UIColor(red: 20/255, green: 25/255, blue: 50/255, alpha: 1.0)
        
        view.applyGradient(
            colors: [topColor, bottomColor],
            startPoint: CGPoint(x: 0.5, y: 0),
            endPoint: CGPoint(x: 0.5, y: 1)
        )

        view.addSubview(userEmail)
        view.addSubview(userPassword)
        view.addSubview(authButton)
        view.addSubview(regButton)
        
        NSLayoutConstraint.activate([
            userEmail.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            userEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            userEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            userEmail.heightAnchor.constraint(equalToConstant: 40),
            
            userPassword.topAnchor.constraint(equalTo: userEmail.bottomAnchor, constant: 20),
            userPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            userPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            userPassword.heightAnchor.constraint(equalToConstant: 40),
            
            authButton.topAnchor.constraint(equalTo: userPassword.bottomAnchor, constant: 40),
            authButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            authButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            authButton.heightAnchor.constraint(equalToConstant: 40),
            
            regButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            regButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            regButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            regButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func textFieldsChanged() {
        let isFilled = !(userEmail.text?.isEmpty ?? true) && !(userPassword.text?.isEmpty ?? true)
        authButton.isEnabled = isFilled
    }
}
