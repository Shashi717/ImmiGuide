//
//  ReadingWritingLiteracyPrograms.swift
//  ImmiGuide
//
//  Created by Cris on 2/18/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class ReadingWritingLiteracyPrograms {
    var programType: String
    var program: String
    var agencyName: String
    var agencyLocation: Location?
    var agencyPhoneNumber: String
    var ageGroup: String
    
    init?(programType: String, program: String, agencyName: String, agencyLocation: Location?, agencyPhoneNumber: String, ageGroup: String) {
        self.programType = programType
        self.program = program
        self.agencyName = agencyName
        self.agencyLocation = agencyLocation
        self.agencyPhoneNumber = agencyPhoneNumber
        self.ageGroup = ageGroup
    }
    
    convenience init?(fromDict: [String : Any]) {
        guard let programType = fromDict["program_type"] as? String,
            let program = fromDict["program"] as? String,
            let name = fromDict["agency"] as? String,
            let phoneNumber = fromDict["contact_number"] as? String,
            let ageGroup = fromDict["grade_level_age_group"] as? String else { return nil }
        
            let location = Location(dict: fromDict)
        
        self.init(programType: programType, program: program, agencyName: name, agencyLocation: location, agencyPhoneNumber: phoneNumber, ageGroup: ageGroup)
    }
    
}
