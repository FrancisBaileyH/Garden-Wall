//
//  WhitelistViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-30.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import UIKit


class WhitelistViewController: UITableViewController {
    

    var fileManager: ContentBlockerFileManager = ContentBlockerFileManager.sharedInstance
    var ruleManager: ContentBlockerRuleManager?
    var rules: [ContentBlockerRule]?
    
    
    override func viewWillAppear(animated: Bool) {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonPressed:")
        self.navigationItem.rightBarButtonItem = addButton
        
        rules = ruleManager?.fetchAll()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ruleManager == nil, let file = fileManager.read("whitelist.json") {

            ruleManager = ContentBlockerRuleManager(data: file)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func addButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("whitelistAddSegue", sender: nil)
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let count = ruleManager?.count() {
            
            if count == 0 {
                setNoDataLabel(tableView)
            }
            else {
                tableView.backgroundView = nil
                tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            }
            
            return count
        }
        
        return 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = rules?[indexPath.row].trigger.ifDomain
        
        return cell
    }
    
    
    func setNoDataLabel(tableView: UITableView) {
        
        let message = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height))
        
        message.text = "No websites whitelisted. Press the plus sign at the top right to add a website to the whitelist."
        message.textColor = UIColor.blackColor()
        message.textAlignment = NSTextAlignment.Center
        message.numberOfLines = 4
        tableView.backgroundView = message
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    
    /*
     * Pass the ruleManager class to the presented view controller
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "whitelistAddSegue" {

            let navController = segue.destinationViewController as! UINavigationController
            let controller    = navController.topViewController as! AddWhitelistItemViewController
            
            controller.ruleManager = self.ruleManager
        }
    }
    
    
    /*
     * Our code was deinitialized so we'll write the JSON back to the file
     * This saves us from writing it each time a change is made, and instead 
     * writes only when we exit this view
    */
    deinit {
        
    }
    
    
    
    
    
}
