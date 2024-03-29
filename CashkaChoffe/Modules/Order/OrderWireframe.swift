//
//  OrderWireframe.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 18.02.2024.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class OrderWireframe: BaseWireframe<OrderViewController> {

    // MARK: - Private properties -

    // MARK: - Module setup -

    init() {
        let moduleViewController = OrderViewController()
        super.init(viewController: moduleViewController)

        let interactor = OrderInteractor()
        let presenter = OrderPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension OrderWireframe: OrderWireframeInterface {
}
