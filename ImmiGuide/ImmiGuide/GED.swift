//
//  GED.swift
//  ImmiGuide
//
//  Created by Cris on 2/18/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation


class GED {
    let address: String
    let borough: String
    let contactNumber: String
    let notes: String?
    let siteName: String
    
    var description: String {
        return "\(address) \n\(borough), New York"
    }
    
    init?(address: String, borough: String, contactNumber: String, notes: String?, siteName: String) {
        self.address = address
        self.borough = borough
        self.contactNumber = contactNumber
        self.notes = notes
        self.siteName = siteName
    }
    
    convenience init?(fromDict: [String : Any]) {
        guard let address = fromDict["address"] as? String,
            let borough = fromDict["borough"] as? String,
            let number = fromDict["contact_number"] as? String,
            let siteName = fromDict["program_site_name"] as? String else { return nil }
        
            let notes = fromDict["notes"] as? String
        
        self.init(address: address, borough: borough, contactNumber: number, notes: notes, siteName: siteName)
    }
}

