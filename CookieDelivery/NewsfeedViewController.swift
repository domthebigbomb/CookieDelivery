//
//  NewsfeedViewController.swift
//  CookieDelivery
//
//  Created by Ella Lee on 2/18/15.
//  Copyright (c) 2015 Dominic Ong. All rights reserved.
//

import Foundation
import UIKit
import Parse
import CoreLocation


class NewsfeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var newsFeedView: UITableView!
    let locationManager = CLLocationManager()
    var myCoordinate: CLLocationCoordinate2D?
    var currUser: PFUser?
    var requests: Array<String>?
    var userInfo: ParseManager?
    
    @IBAction func showProfile(sender: AnyObject) {
        self.performSegueWithIdentifier("goToProfile", sender: self)
    }
    
    @IBAction func addRequest(sender: AnyObject) {
        self.performSegueWithIdentifier("addRequestSegue", sender: self)
    }
    
    override func viewDidLoad() {
        userInfo = ParseManager.sharedInstance
        println("user info: " + userInfo!.returnUser().description)
        
        
        println(currUser?.description)
        requests = Array<String>()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        newsFeedView.delegate = self
        newsFeedView.dataSource = self
        if CLLocationManager.authorizationStatus() == .NotDetermined{
            locationManager.requestAlwaysAuthorization()
            
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("Status " + CLLocationManager.debugDescription())
        if status == CLAuthorizationStatus.NotDetermined {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("updated location!")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error with manager: " + error.localizedDescription)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellToReturn: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("requestCell") as! UITableViewCell
        cellToReturn.textLabel!.text = String(indexPath.row)
        
        return cellToReturn
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var reqCount = requests?.count
        return reqCount!
    }
    
}