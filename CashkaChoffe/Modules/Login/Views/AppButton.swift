//
//  AppButton.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 08.02.2024.
//

import UIKit

class AppButton: UIButton {
    
    // MARK: - Life
    
    init(action: Selector) {
        super.init(frame: .zero)
        setTitleColor(.appButtonText, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        addTarget(nil, action: action, for: .touchUpInside)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - extension
private extension AppButton {
    func setupView() {
        backgroundColor = .appButton
        clipsToBounds = true
        layer.cornerRadius = 24
        snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
}
