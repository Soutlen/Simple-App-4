//
//  RegViewController.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/26/25.
//

import UIKit

protocol RegViewProtocol: AnyObject {
    
}

final class RegViewController: UIViewController, RegViewProtocol {
    
    var presenter: RegPresenterProtocol!
    
    //MARK: -UI Components
    
    private lazy var userName = makeTextField(
        placeholder: "Введите user name",
        target: self,
        action: #selector(textFieldsChanged),
        for: .editingChanged)
    
    
    private lazy var userEmail = makeTextField(
        placeholder: "Введите email",
        target: self,
        action: #selector(textFieldsChanged),
        for: .editingChanged)
    
    private lazy var userPassword = makeTextField(
        placeholder: "Введите password",
        isSecureTextEntry: true,
        target: self,
        action: #selector(textFieldsChanged),
        for: .editingChanged)
    
    private lazy var regButton = makeButton(
        title: "Регистрация",
        backColor: .systemPurple,
        isEnabled: false
    ) { _ in
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        NotificationCenter.default.post(
            name: .setRoot,
            object: nil,
            userInfo: ["screen" : "tabBar"])
        }
    
    lazy var authButton = makeButton(
        title: "Авторизация",
        backColor: .clear,
        isEnabled: false
    ) { _ in
        NotificationCenter.default.post(
            name: .setRoot,
            object: nil,
            userInfo: ["screen" : "auth"])
        }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
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
        
        view.addSubview(userName)
        view.addSubview(userEmail)
        view.addSubview(userPassword)
        view.addSubview(regButton)
        view.addSubview(authButton)
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            userName.heightAnchor.constraint(equalToConstant: 40),
            
            userEmail.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 20),
            userEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            userEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            userEmail.heightAnchor.constraint(equalToConstant: 40),
            
            userPassword.topAnchor.constraint(equalTo: userEmail.bottomAnchor, constant: 20),
            userPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            userPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            userPassword.heightAnchor.constraint(equalToConstant: 40),
            
            regButton.topAnchor.constraint(equalTo: userPassword.bottomAnchor, constant: 40),
            regButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            regButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            regButton.heightAnchor.constraint(equalToConstant: 40),
            
            authButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            authButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            authButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            authButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func textFieldsChanged() {
        let isFilled = !(userName.text?.isEmpty ?? true) && !(userEmail.text?.isEmpty ?? true) && !(userPassword.text?.isEmpty ?? true)
        regButton.isEnabled = isFilled
    }
}
