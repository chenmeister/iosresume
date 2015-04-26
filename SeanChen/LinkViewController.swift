//
//  LinkViewController.swift
//  SeanChen
//
//  Created by Sean Chen on 4/26/15.
//  Copyright (c) 2015 DCMeisterApps. All rights reserved.
//

import UIKit

class LinkViewController: UIViewController {

    var linkToDisplay:String?
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewDidAppear(animated: Bool) {

        // Check if there's an link to display
        if let actualLinkToDiplay = self.linkToDisplay {
            // Create NSURL for the article URL
            let url:NSURL? = NSURL(string: actualLinkToDiplay)
            
            if let actualUrl = url {
                
                // Create NSURLRequest for the NSURL
                let urlRequest:NSURLRequest = NSURLRequest(URL: url!)
                
                // Pass the request into the webview to load the page
                self.webView.loadRequest(urlRequest)
            }
            
        }
        
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
