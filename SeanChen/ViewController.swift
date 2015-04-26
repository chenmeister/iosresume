//
//  ViewController.swift
//  SeanChen
//
//  Created by Sean Chen on 4/24/15.
//  Copyright (c) 2015 DCMeisterApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuView: UITableView!
    
    var menuOptions:[String] = ["Bio", "Experience", "Education", "Skills", "Projects", "Contact"]
    var selectOption:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.menuView.delegate = self
        self.menuView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuOptions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = menuView.dequeueReusableCellWithIdentifier("TableCell") as! UITableViewCell
        
        cell.textLabel?.text = self.menuOptions[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // User has selected a row
        self.selectOption = self.menuOptions[indexPath.row]
        
        // If user selects a row, run segue to the next element and show content
        
        self.performSegueWithIdentifier("toDetailSegue", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detailVC = segue.destinationViewController as! DetailViewController
        
        detailVC.sectionToDisplay = self.selectOption
    }
    
}

