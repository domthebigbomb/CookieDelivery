//
//  AddRequestViewController.swift
//  CookieDelivery
//
//  Created by Dominic Ong on 2/28/15.
//  Copyright (c) 2015 Dominic Ong. All rights reserved.
//

import Foundation
import Parse
import UIKit

class AddRequestViewController: UIViewController, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    var myCoordinate: CLLocationCoordinate2D?
    
    @IBOutlet weak var requestDescription: UITextView!
    
    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var myLocation = manager.location
        myCoordinate = myLocation.coordinate
        println("updated location")
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("error with location manager " + error.localizedDescription)
    }
    
    @IBAction func postRequest(sender: AnyObject) {
        //do something here
        var requestPost = PFObject(className: "Request")
        var textBox = requestDescription.text
        
        var parseManager = ParseManager.sharedInstance
        var userProfile = parseManager.returnUser()
        requestPost["requestedBy"] = userProfile
        
        if let coordinate = myCoordinate{
            var coordinateToPass = PFGeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
            println("the latitude = " + String(coordinateToPass.description))
            //println("the longitude = " + coordinate.longitude)
            requestPost["requesterLocation"] = coordinateToPass
        }
    
        requestPost["description"] = textBox
        requestPost.saveInBackgroundWithBlock { (success:Bool, error:NSError!) -> Void in
            if success{
                println("saved successfully")
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                println("error saving description " + error.localizedDescription)
            }
        }
    }
    
    @IBAction func cancelPost(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
