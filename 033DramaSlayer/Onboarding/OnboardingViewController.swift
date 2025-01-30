//
//  OnboardingViewController.swift
//  033DramaSlayer
//
//  Created by Владимир on 16.01.2025.
//

import UIKit
import SnapKit
import UserNotifications

class OnboardingViewController: UIViewController {
    
    let model: MainModel
    private lazy var numberTab = 0
    
    private let onbarr: [Onboarding] = [Onboarding(image: .onb1, mainText: "Thousands of unique\nseries in our app!", subText: "Enjoy a huge catalogue of TV series\nto suit every mood and time."), Onboarding(image: .onb2, mainText: "Sharp dramas and\ngripping stories!", subText: "Immerse yourself in series that keep you\nin suspense until the last frame."), Onboarding(image: .onb3, mainText: "Passion, drama and\nunrequited love!", subText: "Stories of first love, heartbreak and forbidden\nfeelings that will not leave indifferent."), Onboarding(image: .onb4, mainText: "Rate our app in the\nAppStore", subText: "Did you like our app?\nShare your impressions!"), Onboarding(image: .onb5, mainText: "Don't miss new trends", subText: "Allow notifications")]
    
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "1")
        collection.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        collection.isPagingEnabled = true
        collection.isUserInteractionEnabled = false
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return collection
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.addTouchFeedback()
        button.layer.cornerRadius = 14
        button.backgroundColor = .secondary
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .appFont(.BodyEmphasized)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .white.withAlphaComponent(0.3)
        pageControl.currentPageIndicatorTintColor  = .white
        pageControl.numberOfPages = onbarr.count - 1
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private let laterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitleColor(.white.withAlphaComponent(0.7), for: .normal)
        button.setTitle("Maybe later", for: .normal)
        button.titleLabel?.font = .appFont(.SubheadlineRegular)
        button.alpha = 0
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
    
    private func setupUI() {
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(54)
            make.bottom.equalTo(pageControl.snp.top).inset(-15)
        }
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
        collection.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).inset(-15)
        }
        
        view.addSubview(laterButton)
        laterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.bottom)
        }
    }
    
    @objc private func nextTapped() {
        
        if numberTab == 3 {
            openAlertRate()
            return
        }
        
        if numberTab == 5 {
            notifyTapped()
            return
        }
        
        numberTab += 1
        
        
        if numberTab <= 3 {
            let index = IndexPath(row: numberTab, section: 0)
            collection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = numberTab
            
        } else {
            let index = IndexPath(row: 4, section: 0)
            collection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            UIView.animate(withDuration: 0.2) {
                self.pageControl.alpha = 0
                self.nextButton.setTitle("Turn on notifications", for: .normal)
                self.laterButton.alpha = 1
            }
        }
        
        
        
    }
    
    struct Onboarding {
        let image: UIImage
        let mainText: String
        let subText: String
    }
    
    private func openAlertRate() {
        
        let alertController = UIAlertController(title: "Rate our app", message: "Please leave a review.", preferredStyle: .alert)
        let rateAction = UIAlertAction(title: "Rate app", style: .default) { _ in
            if let url = URL(string: "itms-apps://itunes.apple.com/app/idYOUR_APP_ID?action=write-review") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                    UserDefaults.standard.set("1", forKey: "like1")
                }
            }
            self.numberTab += 1
            self.nextTapped()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)  { _ in
            self.numberTab += 1
            self.nextTapped()
        }
        alertController.addAction(rateAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)

    }
    
    
    @objc private func laterButtonTapped() {
        self.navigationController?.setViewControllers([TabBarViewController(model: model)], animated: true)
    }
    
    @objc private func notifyTapped() {
           UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
               if granted {
                   UserDefaults.standard.set(true, forKey: "notify")
               }
               DispatchQueue.main.async { [weak self] in
                   self?.laterButtonTapped()
               }
           }
    }

    
}


extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onbarr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "1", for: indexPath)
        cell.subviews.forEach { $0.removeFromSuperview() }
        
        let item = onbarr[indexPath.row]
        
        let subLabel = UILabel()
        subLabel.text = item.subText
        subLabel.font = .appFont(.SubheadlineRegular)
        subLabel.textColor = .white.withAlphaComponent(0.7)
        subLabel.textAlignment = .center
        subLabel.numberOfLines = 2
        cell.addSubview(subLabel)
        subLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(40)
            make.height.equalTo(indexPath.row == 4 ? 20 : 40)
        }
        
        let mainLabel = UILabel()
        mainLabel.text = item.mainText
        mainLabel.textColor = .white
        mainLabel.numberOfLines = 2
        mainLabel.textAlignment = .center
        mainLabel.font = .appFont(.Title1Emphasized)
        cell.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.equalTo(subLabel.snp.top).inset(-10)
            make.height.equalTo(indexPath.row == 4 ? 34 : 68)
        }
        
        let imageView = UIImageView(image: item.image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        cell.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(mainLabel.snp.top)
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
}
