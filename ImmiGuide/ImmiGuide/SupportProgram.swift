//
//  SupportProgram.swift
//  ImmiGuide
//
//  Created by Madushani Lekam Wasam Liyanage on 2/18/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

enum SupportProgramModelParseError: Error {
    case results(json: Any)
}

enum ServiceType: String {
    case immigrantServices = "Immigration Services,Immigrant Support Services"
    case ndaServices = "Immigration Services,Immigrant Support Services,NDA Programs"
}

enum SupportProgramType: String {
    case legalServices = "Legal Services"
    case domesticViolence = "Domestic Violence Program"
    case immigrantFamilies = "Services - Immigrant Families"
    case legalAssistance = "Legal Assistance Program"
    case ndaImmigrants = "NDA Immigrants"
    case youthServices = "Legal Services - Immigrant Youth"
    case refugeeAssistance = "Immigrant/Refugee Assistance"
}

class SupportProgram {
    
    let programType: ServiceType.RawValue
    let program: SupportProgramType.RawValue
    let ageGroup: String
    let agency: String
    let siteName: String
    let contactNumber: String
    let location: Location
    
    init(programType: ServiceType.RawValue, program: SupportProgramType.RawValue, ageGroup: String, agency: String, siteName: String, contactNumber: String, location: Location) {
        self.programType = programType
        self.program = program
        self.ageGroup = ageGroup
        self.agency = agency
        self.siteName = siteName
        self.contactNumber = contactNumber
        self.location = location
    }
    
    static func getSupportPrograms(from data: Data) -> [SupportProgram]? {
        var supportProgramsToReturn: [SupportProgram] = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response: [[String:AnyObject]] = jsonData as? [[String:AnyObject]] else {
                throw SupportProgramModelParseError.results(json: jsonData)
                
            }
            
            for dict in response {
                
                if let programType = dict["program_type"] as? String,
                    let program = dict["program"] as? String,
                    let ageGroup = dict["grade_level_age_group"] as? String,
                    let agency = dict["agency"] as? String,
                    let siteName = dict["site_name"] as? String,
                    let contactNumber = dict["contact_number"] as? String,
                    let location = Location(dict: dict) {
                    
                    let program = SupportProgram.init(programType: programType, program: program, ageGroup: ageGroup, agency: agency, siteName: siteName, contactNumber: contactNumber, location: location)
                    supportProgramsToReturn.append(program)
                }
            }
        }
        catch let SupportProgramModelParseError.results(json: json)  {
            print("Error encountered with parsing elements for object: \(json)")
        }
            
        catch {
            print("Unknown parsing error")
        }
        
        return supportProgramsToReturn
    }
    
}

