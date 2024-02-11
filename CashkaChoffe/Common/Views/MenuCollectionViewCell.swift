//
//  MenuCollectionViewCell.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 11.02.2024.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.appPlaceholderText, for: .normal)
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
        button.setTitleColor(.appPlaceholderText, for: .normal)
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
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appPlaceholderText
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.textColor = .appText
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    var minusButtonCompletion: (() -> Void)?
    var plusButtonCompletion: (() -> Void)?
    
    // MARK: - Life
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
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
    
    func configure(item: CoffeeModel, countText: String) {
        imageView.backgroundColor = .appButton
        
        Network.loadImage(urlString: item.imageURL) { result in
            switch result {
            case .success(let data):
                self.imageView.image = UIImage(data: data)
            case .failure:
                self.imageView.image = UIImage()
            }
        }
        
        mainLabel.text = item.name
        secondLabel.text = "\(item.price) руб"
        countLabel.text = countText
    }
    
}

// MARK: - setupViews
extension MenuCollectionViewCell {
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(mainLabel)
        contentView.addSubview(counterStackView)
        contentView.addSubview(secondLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(11)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(11.0)
            make.leading.equalTo(mainLabel)
            make.bottom.equalToSuperview().inset(12.0)
        }
        
        counterStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(secondLabel)
            make.trailing.equalToSuperview().inset(5)
            make.leading.greaterThanOrEqualTo(secondLabel.snp.trailing).offset(3)
        }
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5.0
        contentView.backgroundColor = .white
        contentView.layer.shadowOpacity = 0.25
        contentView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        contentView.layer.shadowRadius = 5.0
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = false
    }
}
