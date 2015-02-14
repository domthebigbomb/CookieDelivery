//
//  SignupViewController.swift
//  CookieDelivery
//
//  Created by Dominic Ong on 2/14/15.
//  Copyright (c) 2015 Dominic Ong. All rights reserved.
//

import Foundation
import UIKit
import Parse

class SignupViewController : ViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        usernameField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        emailField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //if login is tapped..
    @IBAction func login(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(self.usernameField.text, password:self.passwordField.text) {
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
    
    
    @IBAction func attemptToRegister(sender: AnyObject) {
        if let username = usernameField.text {
            if let password = passwordField.text {
                if let passwordConfirm = confirmPasswordField.text{
                    if password == passwordConfirm {
                        var email = emailField.text
                        var user = PFUser()
                        user.username = username
                        user.password = password
                        user.email = email
                        user.signUpInBackgroundWithBlock{
                            (succeeded: Bool!, error: NSError!) -> Void in
                            if error == nil {
                                println("Successfully signed up user")
                                self.dismissViewControllerAnimated(true, completion: nil)
                            }else{
                                let errorString = error.localizedDescription
                                println(errorString)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func dismissRegistration(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}