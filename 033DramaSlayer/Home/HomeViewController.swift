//
//  HomeViewController.swift
//  033DramaSlayer
//
//  Created by Владимир on 16.01.2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    let model: MainModel
    
    init(model: MainModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNav()
        print(324)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgMain
        // Do any additional setup after loading the view.
    }
    

    private func setupNav() {
        let proButton = UIButton(type: .system)
        proButton.layer.cornerRadius = 16
        proButton.backgroundColor = model.returnBGButtonColor()
        proButton.setImage(.iconProfile.resize(targetSize: CGSize(width: 14, height: 22)), for: .normal)
        proButton.tintColor = model.returnBGButtonColorIcon()
        proButton.contentHorizontalAlignment = .center
        
        let leftItem = UIBarButtonItem(customView: proButton)
        
        if model.purchaseManager.isProAccessAvailable {
            proButton.setBackgroundImage(.proCorner, for: .normal)
            
        }
        
        self.tabBarController?.navigationItem.leftBarButtonItem = leftItem
        proButton.snp.makeConstraints { make in
            make.height.width.equalTo(32)
        }
        proButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        
    }
    
    @objc func openSettings() {
        let paywallViewController = SettingsViewController(model: model)
        paywallViewController.modalPresentationStyle = .fullScreen
        paywallViewController.modalTransitionStyle = .coverVertical
        if #available(iOS 13.0, *) {
            paywallViewController.isModalInPresentation = true
        }
        self.present(paywallViewController, animated: true)
    }

}
