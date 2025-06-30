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
    private lazy var userEmail: UITextField = {
        $0.text = ""
        $0.placeholder = "Введите email"
        $0.textColor = .red
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
        $0.keyboardType = .default
        $0.returnKeyType = .done
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    private lazy var userPassword: UITextField = {
        $0.text = ""
        $0.placeholder = "Введите password"
        $0.textColor = .red
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.borderStyle = .roundedRect
        $0.keyboardType = .default
        $0.returnKeyType = .done
        $0.isSecureTextEntry = true
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    private lazy var authButton: UIButton = {
        $0.setTitle("Войти", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.backgroundColor = .systemPurple
        $0.layer.cornerRadius = 20
        $0.isEnabled = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: actionAuthButton))
    
    private lazy var regButton: UIButton = {
        $0.setTitle("Регистрация", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: actionRegButton))
    
    lazy var actionRegButton = UIAction { [weak self] _ in
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        NotificationCenter.default.post(
            name: .setRoot,
            object: nil,
            userInfo: ["screen" : "reg"]
        )
    }
    
    lazy var actionAuthButton = UIAction { [weak self] _ in
        NotificationCenter.default.post(
            name: .setRoot,
            object: nil,
            userInfo: ["screen" : "tabBar"]
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
