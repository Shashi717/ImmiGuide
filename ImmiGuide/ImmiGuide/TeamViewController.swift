//
//  TeamViewController.swift
//  ImmiGuide
//
//  Created by Annie Tung on 2/19/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var teamCollectionView: UICollectionView!
    
    let teamArray = ["Annie Tung","Christopher Chavez", "Eashir Arafat", "Madushani Lekam Wasam Liyanage"]
    let titleArray = ["Design Lead", "Project Manager", "Demo Lead", "Technical Lead"]
    let teamDict = ["Annie Tung":"https://www.linkedin.com/in/tungannie/", "Christopher Chavez": "https://www.linkedin.com/in/cristopher-chavez-6693b965/", "Eashir Arafat":"https://www.linkedin.com/in/eashirarafat/", "Madushani Lekam Wasam Liyanage":"https://www.linkedin.com/in/madushani-lekam-wasam-liyanage-74319bb5/"]
    var selectedTeamMember = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamCollectionView.delegate = self
        teamCollectionView.dataSource = self
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "TeamIcon"))
        
        teamCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "teamCellIdentifier")
        let nib = UINib(nibName: "TeamDetailCollectionViewCell", bundle:nil)
        teamCollectionView.register(nib, forCellWithReuseIdentifier: "teamCellIdentifier")
    }
    
    // MARK: - Collection View Data Source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCellIdentifier", for: indexPath) as! TeamDetailCollectionViewCell
        cell.nameLabel.text = teamArray[indexPath.row]
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.imageView.image = UIImage(named: teamArray[indexPath.row])
        cell.setNeedsLayout()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTeamMember = teamArray[indexPath.row]
        performSegue(withIdentifier: "LinkedInSegue", sender: self)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LinkedInSegue" {
            if let cuvc = segue.destination as? ContactUsViewController {
                cuvc.url = teamDict[selectedTeamMember]
            }
        }
    }
}
