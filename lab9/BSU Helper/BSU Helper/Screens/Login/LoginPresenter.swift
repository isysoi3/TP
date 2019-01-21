//
//  LoginPresenter.swift
//  BSU Helper
//
//  Created by Ilya Sysoi on 4/28/18.
//  Copyright © 2018 isysoi. All rights reserved.
//

import Foundation

class LoginPresenter {
    
    private var view: LoginViewProtocol!
    
    func onViewDidLoad(view: LoginViewProtocol) {
        self.view = view
    }
    
    func loginButtonTapped(login: String?, password: String?) {
        if let login = login,
            let password = password,
            login != "",
            password != ""{
            if let realPassword = UserDefaults.standard.string(forKey: login),
                realPassword == password {
                view.showSuccessLogin()
            } else  {
                view.showErrorLogin()
            }
        } else {
           view.showEmptyFieldsError()
        }
    }
    
}
