//
//  JobViewController.swift
//  SeanChen
//
//  Created by Sean Chen on 4/26/15.
//  Copyright (c) 2015 DCMeisterApps. All rights reserved.
//

import UIKit

class JobViewController: UIViewController {

    var companyName:String?
    var jobDescription:String?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = companyName.self
        
        self.descriptionLabel.text = jobDescription.self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
