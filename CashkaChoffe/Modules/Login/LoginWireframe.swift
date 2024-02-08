//
//  LoginWireframe.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 08.02.2024.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class LoginWireframe: BaseWireframe<LoginViewController> {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init() {
        let moduleViewController = LoginViewController()
        super.init(viewController: moduleViewController)

        let interactor = LoginInteractor()
        let presenter = LoginPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension LoginWireframe: LoginWireframeInterface {
}