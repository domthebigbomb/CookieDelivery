//
//  ViewController.swift
//  CookieDelivery
//
//  Created by Dominic Ong on 2/12/15.
//  Copyright (c) 2015 Dominic Ong. All rights reserved.
//

//ella lee

import UIKit
import Parse

class ViewController: UIViewController {
    
    var hi : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Dominic Ong
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground("myname", password:"mypw") {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login. ^ edit this part
            } else {
                var alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed"
                alertView.message = "Please re-enter username and password"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
    }

}

