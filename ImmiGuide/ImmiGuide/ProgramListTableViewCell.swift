//
//  ProgramListTableViewCell.swift
//  ImmiGuide
//
//  Created by Madushani Lekam Wasam Liyanage on 2/18/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit

class ProgramListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UIButton!
    @IBOutlet weak var directionLabel: UIButton!
    
    @IBAction func didTapOpenMap(_ sender: UIButton) {
        guard let address  = addressLabel.text else { return }
        let validAddress = address.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "%20")
        let url = "http://maps.apple.com/?address=" + validAddress
        if let url = NSURL(string: url) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func contactNumberButton(_ sender: UIButton) {
        guard let phoneNumber = phoneNumberLabel.title(for: .normal) else { return }
        let validPhoneNumber = phoneNumber.replacingOccurrences(of: "Contact: ", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: " ", with: "")
        UIApplication.shared.open(NSURL(string: "tel://\(validPhoneNumber)") as! URL, options: [:], completionHandler: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        phoneNumberLabel.titleLabel?.font = UIFont(name: "Montserrat-Light", size: 16)
        directionLabel.titleLabel?.font = UIFont(name: "Montserrat-Light", size: 16)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
