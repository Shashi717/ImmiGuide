//
//  ProfileViewController.swift
//  ImmiGuide
//
//  Created by Annie Tung on 2/19/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource,UITabBarControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    let imageNames = ["Spain", "china", "united-states"]
    var currentLanguage: String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let userDefaults = UserDefaults.standard
        let appLanguage = userDefaults.object(forKey: TranslationLanguage.appLanguage.rawValue)
        if let language = appLanguage as? String,
            let languageDict = Translation.tabBarTranslation[language],
            let firstTab = languageDict["Settings"] {
            self.navigationController?.tabBarItem.title = firstTab
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes =
            ([NSForegroundColorAttributeName: UIColor.white])
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Settings-64"))
        self.navigationController?.navigationBar.barTintColor = UIColor(red:1.00, green:0.36, blue:0.36, alpha:1.0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        self.collectionView.register(SettingCollectionViewCell.self, forCellWithReuseIdentifier: SettingCollectionViewCell.identifier)
        tableView.rowHeight = 75
        tableView.preservesSuperviewLayoutMargins = false
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorColor = UIColor.darkGray
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentLanguage = Translation.getLanguageFromDefauls()
        collectionView.reloadData()
    }
    
    // MARK: - Collection View
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCollectionViewCell.identifier, for: indexPath) as! SettingCollectionViewCell
        let imageName = imageNames[indexPath.item]
        let language = Translation.languageFrom(imageName: imageName)
        currentLanguage = Translation.getLanguageFromDefauls()
        if language == currentLanguage {
            cell.flagImage.image = UIImage(named: imageName)
            cell.alpha = 1.0
            cell.layoutIfNeeded()
            
        } else {
            cell.flagImage.image = UIImage(named: imageName)
            cell.alpha = 0.40
            cell.layoutIfNeeded()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageName = imageNames[indexPath.item]
        let language = Translation.languageFrom(imageName: imageName)
        let defaults = UserDefaults()
        defaults.setValue(language, forKey: TranslationLanguage.appLanguage.rawValue)
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width * 0.25
        return CGSize(width: width, height: width)
    }
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeetTheTeam", for: indexPath) as! MeetTheTeamTableViewCell
            cell.teamLabel?.text = " Meet The Team"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Feedback", for: indexPath) as! MeetTheTeamTableViewCell
            cell.feedbackLabel?.text = " Send Us Feedback"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MeetTheTeam", for: indexPath) as! MeetTheTeamTableViewCell
            return cell
        }
    }

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "GoogleFormSegue" {
                if let cuvc = segue.destination as? ContactUsViewController {
                    cuvc.url = "https://docs.google.com/forms/d/e/1FAIpQLSc4fVNv7jHBJemmRgPOvdavjWsAZf3gZ221U6aR6BjLHK5llA/viewform"
                }
            }
     }
   
    
}
