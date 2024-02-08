//
//  UIStoryboardExtension.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 08.02.2024.
//

import UIKit

extension UIStoryboard {

    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }

}
