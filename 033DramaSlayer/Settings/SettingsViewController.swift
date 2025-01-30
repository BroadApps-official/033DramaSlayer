//
//  SettingsViewController.swift
//  033DramaSlayer
//
//  Created by Владимир on 17.01.2025.
//

import UIKit
import ApphudSDK

class SettingsViewController: UIViewController {
    
    let model: MainModel
    
    init(model: MainModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    let proImage: UIImageView = {
        let imageView = UIImageView(image: .bigProCorner)
        return imageView
    }()
    
    private lazy var namelabel: UILabel = {
        let label = UILabel()
        label.text = model.profileSettings.name
        label.textColor = .white
        label.font = .appFont(.Title2Emphasized)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var profileButton = createProfileButton()
    
    private lazy var idButton: UIButton = {
        let button = UIButton()
        button.addTouchFeedback()
        button.backgroundColor = .clear
        
        let label = UILabel()
        label.text = "ID:\(Apphud.userID())"
        label.textColor = .white.withAlphaComponent(0.7)
        label.font = .appFont(.FootnoteRegular)
        label.textAlignment = .center
        
        button.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        let copyImageView = UIImageView(image: .copyID)
        button.addSubview(copyImageView)
        copyImageView.snp.makeConstraints { make in
            make.height.equalTo(12)
            make.width.equalTo(11)
            make.centerY.equalToSuperview()
            make.left.equalTo(label.snp.right).inset(-2)
        }
        
        return button
    }()
    
    private let subscriptionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(.detailProButton, for: .normal)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileButton = createProfileButton()
        checkPro()
        print(34)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgMain
        setupUI()
    }
    
    private func setupUI() {
        let goBackButton = UIButton(type: .system)
        goBackButton.setBackgroundImage(.backButton, for: .normal)
        view.addSubview(goBackButton)
        goBackButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(41)
            make.left.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        view.addSubview(profileLabel)
        profileLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(goBackButton)
        }
        
        let editButton = UIButton(type: .system)
        editButton.setBackgroundImage(.editButton, for: .normal)
        view.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(38)
            make.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        view.addSubview(proImage)
        proImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileLabel.snp.bottom).inset(-15)
            make.height.width.equalTo(81)
        }
        
        proImage.addSubview(profileButton)
        profileButton.snp.makeConstraints { make in
            make.height.width.equalTo(71)
            make.center.equalToSuperview()
        }
        
        view.addSubview(namelabel)
        namelabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(proImage.snp.bottom).inset(-15)
        }
        
        view.addSubview(idButton)
        idButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(namelabel.snp.bottom).inset(-15)
            make.height.equalTo(20)
        }
        idButton.addTarget(self, action: #selector(copyID), for: .touchUpInside)
        
        view.addSubview(subscriptionButton)
        subscriptionButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(60)
            make.width.lessThanOrEqualTo(360)
            make.top.equalTo(idButton.snp.bottom).inset(-20)
        }
        subscriptionButton.addTarget(self, action: #selector(openPaywall), for: .touchUpInside)
    }
    
    private func checkPro() {
        if model.purchaseManager.isProAccessAvailable {
            proImage.alpha = 1
        } else {
            proImage.alpha = 0
        }
        namelabel.text = model.profileSettings.name
    }

    
    @objc private func goBack() {
        self.dismiss(animated: true)
    }
    
    private func createProfileButton() -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 35.5
        button.backgroundColor = model.returnBGButtonColor()
        button.setImage(.iconProfile.resize(targetSize: CGSize(width: 39, height: 39)), for: .normal)
        button.tintColor = model.returnBGButtonColorIcon()
        button.contentHorizontalAlignment = .center
        return button
    }
    
    @objc private func copyID() {
        let textToCopy = "\(Apphud.userID())"
        UIPasteboard.general.string = textToCopy
    }
    
    @objc func openPaywall() {
        let paywallViewController = PaywallViewController(model: model)
        paywallViewController.modalPresentationStyle = .fullScreen
        paywallViewController.modalTransitionStyle = .coverVertical
        if #available(iOS 13.0, *) {
            paywallViewController.isModalInPresentation = true
        }
        self.present(paywallViewController, animated: true)
    }
    
}
