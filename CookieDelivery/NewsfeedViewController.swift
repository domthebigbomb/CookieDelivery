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


class NewsfeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newsFeedView: UITableView!
    var currUser: PFUser?
    var requests: Array<String>?
    
    override func viewDidLoad() {
        println(currUser?.description)
        requests = Array<String>()
        var obj1 = PFObject(className: "Request")
        var obj2 = PFObject(className: "Request")
        requests?.append("1")
        requests?.append("2")
        newsFeedView.delegate = self
        newsFeedView.dataSource = self
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellToReturn: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("requestCell") as UITableViewCell
        cellToReturn.textLabel!.text = String(indexPath.row)
        
        return cellToReturn
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var reqCount = requests?.count
        return reqCount!
    }
    
}