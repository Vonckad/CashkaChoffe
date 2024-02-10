//
//  TitleTextField.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 08.02.2024.
//

import UIKit

class TitleTextField: UIView {
    
    enum TitleTextFieldType {
        case email, password, retryPassword
        
        var placeholder: String {
            switch self {
            case .email: return "example@example.ru"
            case .password, .retryPassword: return "******"
            }
        }
        
        var title: String {
            switch self {
            case .email: return "e-mail"
            case .password: return "Пароль"
            case .retryPassword: return "Повторите пароль"
            }
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.textColor = .appText
        label.text = type.title
        return label
    }()
    
    private lazy var textField: TextField = {
        let textField = TextField()
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 23.5
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.appText.cgColor
        textField.keyboardType = type == .email ? .emailAddress : .default
        textField.isSecureTextEntry = type != .email
        textField.textColor = .appText
        textField.tintColor = .appPlaceholderText
        textField.attributedPlaceholder = NSAttributedString(
            string: type.placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.appPlaceholderText]
        )
        return textField
    }()
    
    private var type: TitleTextFieldType
    
    // MARK: - Life
    
    init(type: TitleTextFieldType) {
        self.type = type
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.type = .email
        super.init(coder: coder)
        setupView()
    }
    
    var text: String? {
        textField.text
    }
}

// MARK: - extension
private extension TitleTextField {
    func setupView() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(self)
            make.height.equalTo(47)
        }
    }
}

fileprivate class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
