//
//  TabBarViewController.swift
//  033DramaSlayer
//
//  Created by Владимир on 16.01.2025.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let model: MainModel
    
    init(model: MainModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "onb")
        setupUI()
    }
    

    private func setupUI() {
        tabBar.backgroundColor = .black
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        tabBar.tintColor = .secondary
        
        let homeVC = HomeViewController(model: model)
        let homeVCItem = UITabBarItem(title: "Home", image: .tab1.resize(targetSize: CGSize(width: 26, height: 21)), tag: 0)
        homeVC.tabBarItem = homeVCItem
        
        let discoverVC = DiscoverViewController(model: model)
        let discoverVCItem = UITabBarItem(title: "Discover", image: .tab2.resize(targetSize: CGSize(width: 26, height: 21)), tag: 1)
        discoverVC.tabBarItem = discoverVCItem
        
        let listVC = ListViewController(model: model)
        let listVCItem = UITabBarItem(title: "My List", image: .tab3.resize(targetSize: CGSize(width: 26, height: 21)), tag: 2)
        listVC.tabBarItem = listVCItem
        
        viewControllers = [homeVC, discoverVC, listVC]
        
        let separator = UIView()
        separator.backgroundColor = .white.withAlphaComponent(0.15)
        tabBar.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(0.33)
        }
    }

}
