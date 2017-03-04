//
//  SupportProgramListViewController.swift
//  ImmiGuide
//
//  Created by Madushani Lekam Wasam Liyanage on 2/18/17.
//  Copyright © 2017 Madushani Lekam Wasam Liyanage. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SupportProgramListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate{
    
    @IBOutlet weak var programListTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    let initialLocation = CLLocation(latitude: 40.7128, longitude: -74.0059)
    let regionRadius: CLLocationDistance = 1000
    
    var programList: [SupportProgram] = []
    var categoryChosen: [ReadingWritingLiteracyPrograms] = []
    var gedLocation: [GED] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        programListTableView.delegate = self
        programListTableView.dataSource = self
        programListTableView.estimatedRowHeight = 100.0
        programListTableView.rowHeight = UITableViewAutomaticDimension
        mapView.delegate = self
        mapView.mapType  = .standard
        mapView.isZoomEnabled = true
        mapView.showsPointsOfInterest = false
        centerMapOnLocation(location: initialLocation)
        
        addPin(at: "NYC", lat: 40.7128, long: -74.0059)
        
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !programList.isEmpty {
            return programList.count
        } else if !categoryChosen.isEmpty {
            return categoryChosen.count
        } else if !gedLocation.isEmpty {
            return gedLocation.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "programIdentifier", for: indexPath) as! ProgramListTableViewCell
        
        if !programList.isEmpty {
            let index = programList[indexPath.row]
            let description = index.location.description
            cell.siteNameLabel.text = index.siteName
            cell.addressLabel.text = description
            cell.phoneNumberLabel.setTitle("\(index.contactNumber)", for: .normal)
            
            cell.siteNameLabel.font = UIFont(name: "Montserrat-Medium", size: 17)
            cell.addressLabel.font = UIFont(name: "Montserrat-Light", size: 16)
            let _ = [cell.siteNameLabel, cell.addressLabel].map{$0?.textColor = UIColor.darkGray}
            
        } else if !categoryChosen.isEmpty {
            let site = categoryChosen[indexPath.row]
            let description = site.agencyLocation?.description
            cell.siteNameLabel.text = site.agencyName
            cell.addressLabel.text = description
            cell.phoneNumberLabel.setTitle("\(site.agencyPhoneNumber)", for: .normal)
            
            cell.siteNameLabel.font = UIFont(name: "Montserrat-Medium", size: 17)
            cell.addressLabel.font = UIFont(name: "Montserrat-Light", size: 16)
            let _ = [cell.siteNameLabel, cell.addressLabel].map{$0?.textColor = UIColor.darkGray}
            
        } else if !gedLocation.isEmpty {
            let site = gedLocation[indexPath.row]
            let description = site.description
            cell.siteNameLabel.text = site.siteName
            cell.addressLabel.text = description
            cell.phoneNumberLabel.setTitle("\(site.contactNumber)", for: .normal)
            
            cell.siteNameLabel.font = UIFont(name: "Montserrat-Medium", size: 17)
            cell.addressLabel.font = UIFont(name: "Montserrat-Light", size: 16)
            let _ = [cell.siteNameLabel, cell.addressLabel].map{$0?.textColor = UIColor.darkGray}
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !programList.isEmpty {
            let index = programList[indexPath.row]
            let geoLocation = index.location.geolocation
            let lat = geoLocation.latitude
            let long = geoLocation.longitude
            addPin(at: index.siteName, lat: lat, long: long)
        } else if  !categoryChosen.isEmpty {
            let index = categoryChosen[indexPath.row]
            let geoLocation = index.agencyLocation?.geolocation
            guard let lat = geoLocation?.latitude,
                let long = geoLocation?.longitude else { return }
            addPin(at: index.agencyName, lat: lat, long: long)
        } else if !gedLocation.isEmpty {
            let index = gedLocation[indexPath.row]
            getGeoFor(gedLocation: index, completionHandler: { (cordinates) -> (Void) in
                DispatchQueue.main.async {
                    self.addPin(at: index.siteName, lat: cordinates.0, long: cordinates.1)
                    self.mapView.reloadInputViews()
                }
            })
        }
    }
    
    func getGeoFor(gedLocation: GED, completionHandler: @escaping ((lat: Double, long: Double)) -> (Void))  {
        let geo = CLGeocoder()
        geo.geocodeAddressString("\(gedLocation.address)") { (placemarkArr, error) in
            guard let placemark = placemarkArr?[0] else { return }
            guard let lat = placemark.location?.coordinate.latitude,
                let long = placemark.location?.coordinate.longitude else { return }
            completionHandler((lat: lat, long: long))
        }
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0,
                                                                  regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addPin(at name: String, lat: Double, long: Double){
        let pinlocation = CLLocation(latitude: lat, longitude: long)
        let pinAnnotation: MKPointAnnotation = MKPointAnnotation()
        pinAnnotation.title = name
        pinAnnotation.coordinate = pinlocation.coordinate
        let oldAnnotations = mapView.annotations
        mapView.removeAnnotations(oldAnnotations)
        mapView.addAnnotation(pinAnnotation)
        centerMapOnLocation(location: pinlocation)
        self.mapView.reloadInputViews()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
