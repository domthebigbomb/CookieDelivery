//
//  ParseManager.swift
//  CookieDelivery
//
//  Created by Dominic Ong on 3/1/15.
//  Copyright (c) 2015 Dominic Ong. All rights reserved.
//

import Foundation
import Parse

class ParseManager: NSObject{
    var user: PFUser?
    
    class var sharedInstance: ParseManager{
        struct Static{
            static let instance: ParseManager = ParseManager()
        }
        return Static.instance
    }
    
    func getNearbyRequests(userLocation:CLLocationCoordinate2D, completion:(requests:[PFObject]) ->()){
        var parseRequest = PFQuery(className: "Request")
        parseRequest.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, parseError:NSError!) -> Void in
            if parseError == nil{
                println("Finished fetching nearby requests. Found \(objects.count) requests")
                if let objects = objects as? [PFObject] {
                    completion(requests: objects)
                }
            }else{
                println("Error: \(parseError) \(parseError.userInfo!)")
            }
        }
    }
    
    func setUserCredentials(profile: PFUser){
        user = profile
        println("setting credentials: " + user!.description)
    }
    
    func returnUser() -> PFUser{
        
        if let actualUser = user{
            return actualUser
        }
        return PFUser()
    }
}

