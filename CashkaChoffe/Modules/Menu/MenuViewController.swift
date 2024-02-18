//
//  MenuViewController.swift
//  CashkaChoffe
//
//  Created by Vlad Ralovich on 11.02.2024.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class MenuViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsets(top: 18.0, left: 16.0, bottom: 0, right: 16.0)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceVertical = true
        return collectionView
        
    }()
    
    private lazy var mainButton = AppButton(action: #selector(mainButtonAction))
    
    // MARK: - Public properties -

    var presenter: MenuPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Меню"
        setupView()
    }
    
    // MARK: - Private

    @objc
    private func mainButtonAction() {
        presenter.mainButtonAction()
    }

}

// MARK: - Extensions -

extension MenuViewController: MenuViewInterface {
    func reloadData() {
        collectionView.reloadData()
    }
}

// MARK: - setupView
private extension MenuViewController {
    
    func setupView() {
        view.backgroundColor = .white
        mainButton.setTitle("Перейти к оплате", for: .normal)
        mainButton.enable(true)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
        }
        
        view.addSubview(mainButton)
        mainButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).offset(18).inset(18)
            make.top.equalTo(collectionView.snp.bottom).offset(18)
            make.bottom.equalTo(view.snp.bottomMargin).offset(20)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath)
        guard let cell = cell as? MenuCollectionViewCell else { return cell }
        cell.configure(item: presenter.item(at: indexPath), countText: "1")
        
        cell.minusButtonCompletion = {
            print("#debug minusButtonCompletion")
        }
        
        cell.plusButtonCompletion = {
            print("#debug plusButtonCompletion")
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = (collectionView.frame.size.height - 40) / 3
        let width = (collectionView.frame.size.width - 45) / 2
        return CGSize(width: width, height: height)
    }
}
