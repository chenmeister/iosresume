//
//  DetailViewController.swift
//  SeanChen
//
//  Created by Sean Chen on 4/25/15.
//  Copyright (c) 2015 DCMeisterApps. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sectionToDisplay:String?
    var linkProject:String?
    var jobDescription:String?
    var companyName:String?
    var projectName:String?
    var arrDict:NSMutableArray = []
    
    
    @IBOutlet weak var showInfo: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.showInfo.delegate = self
        self.showInfo.dataSource = self
        
        self.showInfo.estimatedRowHeight = 100.0
        self.showInfo.rowHeight = UITableViewAutomaticDimension
        
        
        self.navigationItem.title = sectionToDisplay.self
        
        // Get array based on item clicked
        self.parseJsonResults()
        self.showInfo.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseJsonResults(){
        let path: NSString = NSBundle.mainBundle().pathForResource("seanchen", ofType: "json")!
        
        var data: NSData = NSData(contentsOfFile: path as String, options: NSDataReadingOptions.DataReadingMapped, error: nil)!
        
        var dict: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary

        if(sectionToDisplay.self == "Bio"){
        
            for var i = 0 ; i < (dict.valueForKey("bio") as! NSArray).count ; i++
            {
                arrDict.addObject((dict.valueForKey("bio") as! NSArray).objectAtIndex(i))
            }
        }
        
        else if(sectionToDisplay.self == "Experience"){
            for var i = 0 ; i < (dict.valueForKey("experience") as! NSArray).count ; i++
            {
                arrDict.addObject((dict.valueForKey("experience") as! NSArray).objectAtIndex(i))
            }

        }
            
        else if(sectionToDisplay.self == "Education"){
            for var i = 0 ; i < (dict.valueForKey("education") as! NSArray).count ; i++
            {
                arrDict.addObject((dict.valueForKey("education") as! NSArray).objectAtIndex(i))
            }
        }
    
        else if(sectionToDisplay.self == "Skills"){
            for var i = 0 ; i < (dict.valueForKey("skills") as! NSArray).count ; i++
            {
                arrDict.addObject((dict.valueForKey("skills") as! NSArray).objectAtIndex(i))
            }
        }
        
        else if(sectionToDisplay.self == "Projects"){
            for var i = 0 ; i < (dict.valueForKey("projects") as! NSArray).count ; i++
            {
                arrDict.addObject((dict.valueForKey("projects") as! NSArray).objectAtIndex(i))
            }
            
            
        }
        
        else if(sectionToDisplay.self == "Contact"){
            for var i = 0 ; i < (dict.valueForKey("contact") as! NSArray).count ; i++
            {
                arrDict.addObject((dict.valueForKey("contact") as! NSArray).objectAtIndex(i))
            }
        }
        
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Count number of items returned from array
        return self.arrDict.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // use identifier based on the link clicked and/or section
        
        let identifier:[String] = ["InfoCell", "DescCell", "DetailCell"]
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier[0]) as! UITableViewCell
        
        if sectionToDisplay.self == "Bio" && self.arrDict[indexPath.row].valueForKey("rightTitle") == nil {
            cell = tableView.dequeueReusableCellWithIdentifier(identifier[1]) as! UITableViewCell
        }
        
        if sectionToDisplay.self == "Skills" {
            cell = tableView.dequeueReusableCellWithIdentifier(identifier[1]) as! UITableViewCell
        }
        
        if sectionToDisplay.self == "Experience" || sectionToDisplay.self == "Education" || sectionToDisplay.self == "Projects" {
            cell = tableView.dequeueReusableCellWithIdentifier(identifier[2]) as! UITableViewCell
        }
        
        let mainLabel:UILabel? = cell.viewWithTag(1) as! UILabel?
        let timeLabel:UILabel? = cell.viewWithTag(2) as! UILabel?
        let sumLabel:UILabel? = cell.viewWithTag(3) as! UILabel?
        
        if let actualMainLabel = mainLabel {
            let linkKey = self.arrDict[indexPath.row].valueForKey("link")
            let descKey = self.arrDict[indexPath.row].valueForKey("description")
            if linkKey != nil || descKey != nil {
                actualMainLabel.textColor = UIColor.blueColor()
            }
            actualMainLabel.text = self.arrDict[indexPath.row].valueForKey("title") as? String
        }
        
        if let actualTimeLabel = timeLabel {
            if self.arrDict[indexPath.row].valueForKey("rightTitle") != nil {
                actualTimeLabel.text = self.arrDict[indexPath.row].valueForKey("rightTitle") as? String
            } else {
                actualTimeLabel.text = self.arrDict[indexPath.row].valueForKey("bottomTitle") as? String
            }
        }
        
        if let actualSumLabel = sumLabel {
            actualSumLabel.text = self.arrDict[indexPath.row].valueForKey("bottomTitle") as? String
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //if the selection is a project
        
       
        self.linkProject = self.arrDict[indexPath.row].valueForKey("link") as? String
            
        if self.linkProject != nil {
            
            self.performSegueWithIdentifier("showWebpage", sender: self)
        }
        
        if sectionToDisplay.self == "Projects" {
            self.projectName = self.arrDict[indexPath.row].valueForKey("title") as? String
        }
        
        if sectionToDisplay.self == "Experience" {
            self.companyName = self.arrDict[indexPath.row].valueForKey("title") as? String
            self.jobDescription = self.arrDict[indexPath.row].valueForKey("description") as? String
            self.performSegueWithIdentifier("jobSegue", sender: self)
        }
        
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Get the new view controller using segue.destinationViewController.
        if self.linkProject != nil {
            
            
            let linkVC = segue.destinationViewController as! LinkViewController
        
            // Pass the selected object to the new view controller.
            linkVC.linkToDisplay = self.linkProject
        }
        
        if sectionToDisplay.self == "Experience" {
            let jobVC = segue.destinationViewController as! JobViewController
            
            jobVC.companyName = self.companyName
            jobVC.jobDescription = self.jobDescription
            
        }
        
    }
    

}
