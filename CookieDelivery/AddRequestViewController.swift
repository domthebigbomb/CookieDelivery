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

class AddRequestViewController: UIViewController{
    
    @IBOutlet weak var requestDescription: UITextView!
    
    @IBAction func postRequest(sender: AnyObject) {
        //do something here
        var requestPost = PFObject(className: "Request")
        var textBox = requestDescription.text
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
