//
//  SupportProgramsViewController.swift
//  ImmiGuide
//
//  Created by Madushani Lekam Wasam Liyanage on 2/18/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit
import Lottie
import SnapKit

class SupportProgramsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UITabBarControllerDelegate {
    
    @IBOutlet weak var contanierView: UIView!
    @IBOutlet weak var supportProgramsTableView: UITableView!
    
    var language: String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let userDefaults = UserDefaults.standard
        let appLanguage = userDefaults.object(forKey: TranslationLanguage.appLanguage.rawValue)
        if let language = appLanguage as? String,
            let languageDict = Translation.tabBarTranslation[language],
            let firstTab = languageDict["Community"] {
            self.navigationController?.tabBarItem.title = firstTab
        }
    }
    
    let apiEndPoint = "https://data.cityofnewyork.us/resource/tm2y-4xcp.json"
    //let apiEndPoint = "https://data.cityofnewyork.us/resource/tm2y-4xcp.json?$$app_token=nm76DTR92XyaW6KqlXQewFfXn"
    
    var programs: [SupportProgram] = []
    let programCatogories: [String] = ["Legal Services", SupportProgramType.domesticViolence.rawValue, SupportProgramType.immigrantFamilies.rawValue, SupportProgramType.ndaImmigrants.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        configureConstraints()
        animateFamilyIcon()
        self.navigationController?.navigationBar.titleTextAttributes =
            ([NSForegroundColorAttributeName: UIColor.white])
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Home-64"))
        self.navigationController?.navigationBar.barTintColor = UIColor(red:1.00, green:0.36, blue:0.36, alpha:1.0)
        self.tabBarController?.delegate = self
        supportProgramsTableView.delegate = self
        supportProgramsTableView.dataSource = self
        supportProgramsTableView.rowHeight = 100.0
        supportProgramsTableView.preservesSuperviewLayoutMargins = false
        supportProgramsTableView.separatorInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        supportProgramsTableView.layoutMargins = UIEdgeInsets.zero
        supportProgramsTableView.separatorColor = UIColor.darkGray
        
        APIRequestManager.manager.getData(endPoint: apiEndPoint) { (data) in
            if let validData = data,
                let validPrograms = SupportProgram.getSupportPrograms(from: validData){
                self.programs = validPrograms
                
                DispatchQueue.main.async {
                    self.supportProgramsTableView.reloadData()
                    self.animateCells()
                }
            }
        }
      
        setupViewHierarchy()
        configureConstraints()
        animateFamilyIcon()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        language = Translation.getLanguageFromDefauls()
        supportProgramsTableView.reloadData()
        animateCells()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programCatogories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = supportProgramsTableView.dequeueReusableCell(withIdentifier: "supportPraogramCellIdentifier", for: indexPath) as! SupportProgramTableViewCell

        cell.titleLabel.font = UIFont(name: "Montserrat-Light", size: 25)
        cell.titleLabel?.textColor = UIColor.darkGray
        let labelName = programCatogories[indexPath.row]
        guard let languageDict = Translation.supportVC[language] as? [String : String],
            let labelNameInLanguage = languageDict[labelName] else { return cell }
        cell.titleLabel.text = labelNameInLanguage
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "programListSegueIdentifier" {
            if let spltc = segue.destination as? SupportProgramListViewController,
                let cell = sender as? SupportProgramTableViewCell,
                let indexPath = supportProgramsTableView.indexPath(for: cell) {
                switch programCatogories[indexPath.row] {
                case "Legal Services":
                    spltc.programList = programs.filter({ (program) -> Bool in
                        program.program == SupportProgramType.legalServices.rawValue || program.program == SupportProgramType.legalAssistance.rawValue
                    })
                    dump(spltc.programList)
                case SupportProgramType.domesticViolence.rawValue:
                    spltc.programList = programs.filter({ (program) -> Bool in
                        program.program == SupportProgramType.domesticViolence.rawValue
                    })
                case SupportProgramType.immigrantFamilies.rawValue:
                    spltc.programList = programs.filter({ (program) -> Bool in
                        program.program == SupportProgramType.immigrantFamilies.rawValue
                    })
                case SupportProgramType.ndaImmigrants.rawValue:
                    spltc.programList = programs.filter({ (program) -> Bool in
                        program.program == SupportProgramType.ndaImmigrants.rawValue
                    })
                default:
                    break
                }
            }
        }
    }
  
    // MARK: Animation
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 1.5, delay: 0.2 * Double(indexPath.row), options: [], animations: {
            cell.alpha = 1.0
        }, completion: nil)
    }
    
    func animateCells() {
        let allVisibleCells = self.supportProgramsTableView.visibleCells
        
        for (index, cell) in allVisibleCells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 100.0, y: 0)
            cell.alpha = 0
            UIView.animate(withDuration: 1.5, delay: 0.2 * Double(index), options: .curveEaseInOut, animations: {
                cell.alpha = 1.0
                cell.transform = .identity
            }, completion: nil)
        }
    }
    
    func animateFamilyIcon() {
        circleAnimationView.play()
        familyImageView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.6, options: .curveEaseIn, animations: {
            self.familyImageView.alpha = 1.0
        }, completion: nil)
    }
  
    // MARK: Setup
  
    func setupViewHierarchy() {
        view.addSubview(circleAndFamilyView)
        view.addSubview(familyImageView)
        view.addSubview(circleAnimationView)
    }
    
    func configureConstraints() {
        self.edgesForExtendedLayout = []
        circleAndFamilyView.snp.makeConstraints { (view) in
            view.top.leading.trailing.equalToSuperview()
            view.bottom.equalTo(supportProgramsTableView.snp.top)
        }
        
        circleAnimationView.snp.makeConstraints { (view) in
            view.centerX.equalTo(circleAndFamilyView.snp.centerX)
            view.centerY.equalTo(circleAndFamilyView.snp.centerY)
            view.height.width.equalTo(self.view.snp.height).multipliedBy(0.47)
        }
        
        familyImageView.snp.makeConstraints { (view) in
            view.height.equalTo(circleAnimationView.snp.height).multipliedBy(0.4)
            view.width.equalTo(circleAnimationView.snp.width).multipliedBy(0.4)
            view.centerX.equalTo(circleAndFamilyView.snp.centerX)
            view.centerY.equalTo(circleAndFamilyView.snp.centerY)
        }
    }
    
    // MARK: Lazy Vars
  
    //Views
    internal lazy var circleAndFamilyView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    internal lazy var circleAnimationView: LAAnimationView = {
        var view: LAAnimationView = LAAnimationView()
        
        view = LAAnimationView.animationNamed("GrayCircle")
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    internal lazy var familyImageView: UIImageView = {
        let image = #imageLiteral(resourceName: "Family")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
        
    }()
}
