//
//  LoginInterfaces.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 08.02.2024.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol LoginWireframeInterface: WireframeInterface {
    func goToCoffeeShops()
}

protocol LoginViewInterface: ViewInterface {
}

protocol LoginPresenterInterface: PresenterInterface {
    func authAction(isRegister: Bool, user: UserModel)
}

protocol LoginInteractorInterface: InteractorInterface {
    func requestAuth(type: LoginInteractor.RequsetType, user: UserModel, completion: @escaping (Result<TokenModel, NetworkError>) -> Void)
}
