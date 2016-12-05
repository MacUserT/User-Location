//
//  ViewController.swift
//  LocationTryout
//
//  Created by Paul Hertroys on 01-01-16.
//  Copyright © 2016 Aurelius Technology Solutions. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var myLocationManager: CLLocationManager?
    @IBOutlet weak var locationDescription: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myLocationManager = CLLocationManager()
        
        print("The authorization status is: \(CLLocationManager.authorizationStatus())")
        
        self.myLocationManager?.requestWhenInUseAuthorization()
        
        print("The authorization status is: \(CLLocationManager.authorizationStatus())")
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied {
            NSLog("We're not allowed to use location services")
        } else {
            NSLog("Location services are allowed.")
        }
        
        self.myLocationManager?.delegate = self
        
        self.myLocationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        if (CLLocationManager.locationServicesEnabled()) {
            NSLog("Location services enabled")
        } else {
            NSLog("Location services not enabled")
        }
        
        //self.myLocationManager?.startUpdatingLocation()
        self.myLocationManager?.requestLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let dateformatter = NSDateFormatter()
        dateformatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        let location = locations.last!
        self.locationDescription.text = dateformatter.stringFromDate(location.timestamp)
        NSLog("The location description is: %@", location.description)
        
        self.locationLabel.text = "Latitude: \(location.coordinate.latitude), longitude: \(location.coordinate.longitude)"
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.locationDescription.text = "There is no location received"
        self.myLocationManager?.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

