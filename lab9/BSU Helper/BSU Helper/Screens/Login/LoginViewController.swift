//
//  LoginViewController.swift
//  BSU Helper
//
//  Created by Ilya Sysoi on 4/28/18.
//  Copyright © 2018 isysoi. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    private var titleLabel: UILabel!
    private var loginTextField: UITextField!
    private var passwordTextField: UITextField!
    private var loginButton: Button!
    private var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = LoginPresenter()
        initAndConfiqureUI()
        
        presenter.onViewDidLoad(view: self)
    }

    private func initAndConfiqureUI() {
        view.backgroundColor = .white
        
        titleLabel = UILabel()
        loginTextField = UITextField()
        passwordTextField = UITextField()
        loginButton = Button(title: "Войти") { [weak self] _ in
            let login = self?.loginTextField.text
            let password = self?.passwordTextField.text
            self?.presenter.loginButtonTapped(login: login, password: password)
        }
        
        confiqureSubviews()
        addSubviews()
        confiqureConstraints()
    }
    
    private func confiqureSubviews() {
        confiqureTextField(loginTextField, placeholder: "логин")
        confiqureTextField(passwordTextField, placeholder: "пароль")
        passwordTextField.isSecureTextEntry = true
        
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.layer.borderColor =  UIColor.black.cgColor
        loginButton.layer.borderWidth = 2
        loginButton.layer.cornerRadius = 5
        
        titleLabel.textColor = .black
        titleLabel.text = "BSU Helper"
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        titleLabel.textAlignment = .center
    }
    
    private func confiqureTextField(_ textField: UITextField,
                                    placeholder: String) {
        textField.addLeftOffsetToTextField(left: 10)
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
    }
    
    private func addSubviews() {
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(titleLabel)
    }
    
    private func confiqureConstraints() {
        loginTextField.snp.makeConstraints { make in
            make.centerY.equalTo(view).offset(-100)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(45)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(15)
            make.left.right.height.equalTo(loginTextField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(25)
            make.left.right.height.equalTo(loginTextField)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(loginTextField.snp.top).offset(-25)
            make.centerX.equalTo(view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension LoginViewController: LoginViewProtocol {
    
    func showEmptyFieldsError() {
        showAlert(withTitle: nil,
                  withText: "Login or password are empty",
                  completionBlock: nil)
    }
    
    func showSuccessLogin() {
        let vc = BSUFacultiesViewController()
        
        UIView.transition(
            with: UIApplication.shared.keyWindow!,
            duration: 0.5,
            options: .transitionCrossDissolve ,
            animations: {
                UIApplication.shared.keyWindow!.rootViewController = vc
        })
        
    }
    
    func showErrorLogin() {
        showAlert(withTitle: nil,
                  withText: "Login or password not",
                  completionBlock: nil)
    }
    
    
}
