//
//  TourViewController.swift
//  ImmiGuide
//
//  Created by Annie Tung on 2/18/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class TourPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    var tourData: [Tour] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTourData()
        setupCollectionView()
        setupPageController()
        setupButton()
        loadUserDefaults()
    }
    
    func saveUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "FirstTime")
    }
    
    func loadUserDefaults() {
        let defaults = UserDefaults.standard
        if let value = defaults.value(forKey: "FirstTime") {
            print(value)
            showHomeScreen()
        }
        else {
            defaults.set(true, forKey: "FirstTime")
            print("FirstTime\(defaults.value(forKey: "FirstTime"))")
        }   
    }
    // MARK: - Methods
    
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TourCell.self, forCellWithReuseIdentifier: TourCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let _ = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ].map{$0.isActive = true}
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func showHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBar")
        self.present(tabBarVC, animated: true, completion: nil)
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "didViewTour")
    }
    
    func setupTourData() {
        if let tourPage1 = UIImage(named: "Tourpage1"), let tourPage2 = UIImage(named: "Tourpage2"), let tourPage3 = UIImage(named: "Flag") {
            let pageOne = Tour(image: tourPage1, title: "ImmiGuide", description: "Discover local resources for immigration support")
            let pageTwo = Tour(image: tourPage2, title: "", description: "New York City has a population of over 8 million people, with approximately 37% of those consist of Immigrants")
            let pageThree = Tour(image: tourPage3, title: "Our Mission", description: "We want to provide easy access resources and empower immigrants to reach their goals. \n\n Ready to explore?")
            tourData = [pageOne, pageTwo, pageThree]
            print("TOUR DATA")
            dump([pageOne, pageTwo, pageThree])
        }
    }
    
    func setupPageController() {
        collectionView.addSubview(pageController)
        let _ = [
            pageController.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            pageController.leftAnchor.constraint(equalTo: view.leftAnchor),
            pageController.rightAnchor.constraint(equalTo: view.rightAnchor),
            ].map{$0.isActive = true}
    }
    
    func setupButton() {
        collectionView.addSubview(getStartedButton)
        let _ = [
            getStartedButton.bottomAnchor.constraint(equalTo: pageController.topAnchor, constant: -20),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.heightAnchor.constraint(equalToConstant: 45),
            getStartedButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75)
            ].map{$0.isActive = true}
    }
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = true
        collection.bounces = false
        collection.showsHorizontalScrollIndicator = true
        return collection
    }()
    
    lazy var pageController: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.numberOfPages = self.tourData.count
        return pageControl
    }()
    
    lazy var getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("GET STARTED", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Light", size: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(showHomeScreen), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        getStartedButton.isHidden = true
        return tourData.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TourCell.identifier, for: indexPath) as! TourCell
        cell.tour = tourData[indexPath.item]
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
        pageController.currentPage = currentPage
        if currentPage == tourData.count - 1 {
            getStartedButton.alpha = 0
            getStartedButton.isHidden = false
            UIView.animate(withDuration: 1.5) {
                self.getStartedButton.alpha = 1
            }
        } else {
            getStartedButton.isHidden = true
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
