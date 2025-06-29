//
//  AuthPresenter.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/26/25.
//

import UIKit

protocol AuthPresenterProtocol: AnyObject {
    func registrationButtonTapped()
}

final class AuthPresenter: AuthPresenterProtocol {
    weak var view: AuthViewProtocol?
    
    init(view: AuthViewProtocol?) {
        self.view = view
    }
    
    func registrationButtonTapped() {
            NotificationCenter.default.post(name: .goToReg, object: nil)
        }
}
