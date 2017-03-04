//
//  Location.swift
//  ImmiGuide
//
//  Created by Cris on 2/18/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import Foundation

class Location {
    var borough: String
    var location: String
    var state: String
    var zip: String
    var geolocation: Geolocation
    
    var description: String {
        return "\(location) \(borough), \(state) \(zip)"
    }
    
    init?(borough: String , location: String, state: String, zip: String, geolocation: Geolocation) {
        self.borough = borough
        self.location = location
        self.state = state
        self.zip = zip
        self.geolocation = geolocation
    }
    
    convenience init?(dict: [String : Any]) {
        guard  let location = dict["location_1_location"] as? String,
            let borough = dict["location_1_city"] as? String,
            let state = dict["location_1_state"] as? String,
            let zip = dict["location_1_zip"] as? String,
            let geo = dict["location_1"] as? [String : Any] else { return nil }
        
        guard let geolocation = Geolocation(geoDict: geo) else { return nil }
        
        self.init(borough: borough , location: location, state: state, zip: zip, geolocation: geolocation)
    }
}
