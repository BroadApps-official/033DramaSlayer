//
//  PaywallViewController.swift
//  033DramaSlayer
//
//  Created by Владимир on 17.01.2025.
//

import UIKit

class PaywallViewController: UIViewController {
    
    let model: MainModel
    
    private lazy var restoreButton = createButtomButtons(title: "Restore Purchases", font: .appFont(.Caption1Regular), color: .white.withAlphaComponent(0.6))
    private lazy var privacyButton = createButtomButtons(title: "Privacy Policy", font: .appFont(.Caption2Regular), color: .white.withAlphaComponent(0.4))
    private lazy var termsButton = createButtomButtons(title: "Terms of Use", font: .appFont(.Caption2Regular), color: .white.withAlphaComponent(0.4))
    
    private let payButton: UIButton = {
        let button = UIButton()
        button.addTouchFeedback()
        button.setBackgroundImage(.payButton, for: .normal)
        return button
    }()
    
    init(model: MainModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgMain
        setupUI()
    }
    
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        return collection
    }()
    
    private let loadMiniIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .white
        return view
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Unlock all features with Pro"
        label.textColor = .white.withAlphaComponent(0.7)
        label.font = .appFont(.SubheadlineRegular)
        return label
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "FAVORITE TV SERIES\nWITHOUT LIMITS!"
        label.textColor = .white
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    

    private func setupUI() {
        view.addSubview(restoreButton)
        restoreButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(termsButton)
        termsButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(13)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(privacyButton)
        privacyButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(15)
            make.height.equalTo(13)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(payButton)
        payButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(54)
            make.bottom.equalTo(privacyButton.snp.top).inset(-15)
        }
        
        let cancelAnyTimeImage = UIImageView(image: .cancelAnyTime)
        view.addSubview(cancelAnyTimeImage)
        cancelAnyTimeImage.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(113)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(payButton.snp.top).inset(-15)
        }
        
        view.addSubview(collection)
        collection.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(cancelAnyTimeImage.snp.top).inset(-15)
            make.height.equalTo(186)
        }
        
        view.addSubview(loadMiniIndicator)
        loadMiniIndicator.snp.makeConstraints { make in
            make.center.equalTo(collection)
        }
        loadMiniIndicator.startAnimating()
        
        view.addSubview(subLabel)
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(collection.snp.top).inset(-15)
            make.height.equalTo(23)
        }
        
        let imageView = UIImageView(image: .paywall)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(subLabel.snp.top).inset(-15)
        }
        
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(subLabel.snp.top).inset(-15)
            make.height.equalTo(85)
        }
        
        let miniProImageView = UIImageView(image: .miniPro)
        view.addSubview(miniProImageView)
        miniProImageView.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(82)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(topLabel.snp.top).inset(-15)
        }
        
        let closeButton = UIButton(type: .system)
        closeButton.setBackgroundImage(.closePaywall, for: .normal)
        closeButton.alpha = 0
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(39)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview()
        }
        closeButton.addTarget(self, action: #selector(closePaywall), for: .touchUpInside)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.3) {
                closeButton.alpha = 1
            }
        }
        
    }
    
    @objc private func closePaywall() {
        self.dismiss(animated: true)
    }
    
    private func createButtomButtons(title: String, font: UIFont, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = font
        return button
    }
    
    

}
