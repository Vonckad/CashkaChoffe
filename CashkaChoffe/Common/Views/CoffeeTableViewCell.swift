//
//  CoffeeTableViewCell.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 11.02.2024.
//

import UIKit

class CoffeeTableViewCell: UITableViewCell {
    
    enum CellType {
        case shop, order
    }
    
    private var contextView: UIView = {
        let contextView = UIView()
        contextView.clipsToBounds = true
        contextView.layer.cornerRadius = 5.0
        contextView.backgroundColor = .appButtonText
        contextView.layer.shadowOpacity = 0.25
        contextView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        contextView.layer.shadowRadius = 5.0
        contextView.layer.shadowColor = UIColor.black.cgColor
        contextView.layer.masksToBounds = false
        return contextView
    }()
    
    private var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appText
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    private var secondLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appPlaceholderText
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.appText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 26, weight: .bold)
        button.addTarget(self, action: #selector(minusButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var countLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .appText
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.appText, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 26, weight: .bold)
        button.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var counterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [minusButton, countLabel, plusButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 9.0
        return stackView
    }()
    
    var minusButtonCompletion: (() -> Void)?
    var plusButtonCompletion: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    @objc
    private func minusButtonAction() {
        minusButtonCompletion?()
    }
    
    @objc
    private func plusButtonAction() {
        plusButtonCompletion?()
    }
    
    // MARK: - Public
    
    func configure(type: CellType = .shop, mainText: String, secondText: String, countText: String = "") {
        mainLabel.text = mainText
        secondLabel.text = secondText
        countLabel.text = countText
        
        if type == .shop {
            minusButton.removeFromSuperview()
            countLabel.removeFromSuperview()
            plusButton.removeFromSuperview()
        }
    }
}

// MARK: - setupView
extension CoffeeTableViewCell {
    func setupView() {
        contentView.addSubview(contextView)
        contextView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.trailing.equalTo(contentView).inset(10)
            make.bottom.equalTo(contentView).inset(6)
        }
        
        contextView.addSubview(counterStackView)
        counterStackView.snp.makeConstraints { make in
            make.trailing.equalTo(contextView).inset(10)
            make.centerY.equalTo(contextView)
        }
        
        contextView.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(contextView).inset(14)
            make.leading.equalTo(contextView).inset(10)
            make.trailing.lessThanOrEqualTo(counterStackView.snp.leading).offset(10)
        }
        
        contextView.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(6)
            make.leading.trailing.equalTo(mainLabel)
            make.bottom.equalTo(contextView).inset(9)
        }
    }
}
