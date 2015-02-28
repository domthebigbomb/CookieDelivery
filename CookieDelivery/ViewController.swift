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
    
    var userFound : PFUser?
    
//    let service = "swiftLogin"
//    let userAccount = "swiftLoginUser"
//    let key = "RandomKey"
    
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userName: UITextField!
    
    
//    override func viewDidAppear(animated: Bool) {
//        let (dictionary, error) = Locksmith.loadDataForUserAccount(userAccount, inService: service)
//        
//        if let dictionary = dictionary {
//            // User is already logged in, Send them to already logged in view.
//        } else {
//            // Not logged in, send to login view controller
//            self.performSegueWithIdentifier("loginScreen", sender: self)
//
//        }
//    }
    

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
        println("before if statement")
        if userName.text != "" && userPassword.text != "" {
            println("after if statement")
            //Not empty do something
            PFUser.logInWithUsernameInBackground(self.userName.text, password:self.userPassword.text) {
                (user: PFUser!, error: NSError!) -> Void in
                println("before if statement 2")
                if user != nil {
                    //go to login page if user isn't nil
                    println("user isn't nil!!!!!!")
                    self.userFound = user
                    self.performSegueWithIdentifier("showApp", sender: self)
                    
                } else {
                    println("user is nil!!!!!!!")
                    var alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign in Failed"
                    alertView.message = "User does not exist"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
            }
        }else{
            //Empty, notify user
            println("empty string!!!!!!")
            var alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed"
            alertView.message = "Please re-enter username and password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showApp"{
            
            var navDest: UINavigationController = segue.destinationViewController as! UINavigationController
            var segDest: NewsfeedViewController =  navDest.topViewController as! NewsfeedViewController
            
            segDest.currUser = userFound
            
        }
    
    }

}

