//
//  LoginPresenter.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 08.02.2024.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class LoginPresenter {
    
    enum LoginState {
        case login, register
        
        var mainButtonTitle: String {
            switch self {
            case .login: return "Войти"
            case .register: return "Регистрация"
            }
        }
        
        var title: String {
            switch self {
            case .login: return "Вход"
            case .register: return "Регистрация"
            }
        }
        
        var secondButtonTitle: String {
            switch self {
            case .login: return "Регистрация"
            case .register: return "Войти"
            }
        }
        
        /// Переключает состояния
        mutating func toggle() {
            self = self == .login ? .register : .login
        }
    }
    
    // MARK: - Private properties -

    private unowned let view: LoginViewInterface
    private let interactor: LoginInteractorInterface
    private let wireframe: LoginWireframeInterface
    
    private var state: LoginState = .login {
        didSet {
            view.updateBy(state: state)
            enableMainButton()
        }
    }
    
    private var email: String = "" {
        didSet {
            enableMainButton()
        }
    }
    
    private var password: String = "" {
        didSet {
            enableMainButton()
        }
    }
    
    private var retryPassword: String = "" {
        didSet {
            enableMainButton()
        }
    }

    // MARK: - Lifecycle -

    init(view: LoginViewInterface, interactor: LoginInteractorInterface, wireframe: LoginWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.view.updateBy(state: state)
    }
    
    private func isValidEmail(_ value: String) -> Bool {
        return value.count > 5 && value.contains("@") && value.contains(".")
    }
    
    private func isValidPassword(_ value: String) -> Bool {
        return value.count >= 5
    }
    
    private func enableMainButton() {
        switch state {
        case .login:
            view.enableMainButton(!email.isEmpty && !password.isEmpty)
        case .register:
            view.enableMainButton(!email.isEmpty && !password.isEmpty && password == retryPassword)
        }
    }
}

// MARK: - Extensions -

extension LoginPresenter: LoginPresenterInterface {
    func toggleState() {
        state.toggle()
    }
    
    func emailTextFieldEditingChanged(_ text: String) {
        email = isValidEmail(text) ? text : ""
    }
    
    func passwordTextFieldEditingChanged(_ text: String) {
        password = isValidPassword(text) ? text : ""
    }
    
    func retryPasswordTextFieldEditingChanged(_ text: String) {
        retryPassword = isValidPassword(text) ? text : ""
    }
    
    func authAction() {
        let user = UserModel(login: email, password: password)
        
        interactor.requestAuth(type: state == .register ? .reister : .login, user: user) { [weak self] result in
            
            guard let self else { return }
            
            switch result {
            case .success(let success):
                print("#debug success = \(success.token)")
                wireframe.goToCoffeeShops()
            case .failure(let failure):
                print("#debug failure = \(failure.localizedDescription)")
            }
        }
    }
}
