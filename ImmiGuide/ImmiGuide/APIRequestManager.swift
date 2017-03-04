//
//  APIRequestManager.swift
//  NASAAPOD
//
//  Created by Madushani Lekam Wasam Liyanage on 11/5/16.
//  Copyright © 2016 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

enum Borough: String {
    case Bronx, Queens, Brooklyn, NewYork = "New%20York", Staten_Island = "Staten%20Island"
}

class APIRequestManager {
    static let appToken = "nm76DTR92XyaW6KqlXQewFfXn"
    static let literacyProgramsAPIEndPoint = "https://data.cityofnewyork.us/resource/vmdh-6fvj.json"
    static let gedAPIEndPoint = "https://data.cityofnewyork.us/resource/jfsi-vq8f.json"
    
    static func makeLiteracyEndPointWithQuery(borough: String) -> String {
        let boroughQuery = "?borough_community=\(borough)"
        return literacyProgramsAPIEndPoint + boroughQuery
    }
    
    static func makeGEDEndPointWithQuery(borough: String) -> String {
        let boroughQuery = "?borough=\(borough)"
        return gedAPIEndPoint + boroughQuery
    }
    
    static let manager = APIRequestManager()
    private init() {}
    
    func getData(endPoint: String, callBack: @escaping (Data?) -> Void) {
        
        guard let myURL = URL(string: endPoint) else {return}
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: myURL){(data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error durring session: \(error)")
            }
       
            guard let validData = data else {return}
            callBack(validData)
            }.resume()
    }
    
    
    
    
    
}
