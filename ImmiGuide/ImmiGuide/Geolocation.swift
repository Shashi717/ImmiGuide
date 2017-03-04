//
//  Geolocation.swift
//  ImmiGuide
//
//  Created by Cris on 2/18/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class Geolocation {
    var type: String
    var latitude: Double
    var longitude: Double
    
    init?(type: String, latitude: Double, longitude: Double) {
        self.type = type
        self.longitude = longitude
        self.latitude = latitude
    }
    
    convenience init?(geoDict: [String : Any]) {
        guard let type = geoDict["type"] as? String,
            let geoArr = geoDict["coordinates"] as? [Double] else { return nil }
        
        guard let latitude = geoArr.last,
            let longitude = geoArr.first else { return nil }
        
        self.init(type: type, latitude: latitude, longitude: longitude)
    }
}
