//
//  RegPresenter.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/26/25.
//

import UIKit

protocol RegPresenterProtocol: AnyObject {

}

class RegPresenter: RegPresenterProtocol {
    weak var view: RegViewProtocol!
    
    init(view: RegViewProtocol!) {
        self.view = view
    }
   
}

