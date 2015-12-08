//
//  WhitelistViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-30.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//


import UIKit
import SafariServices



class WhitelistViewController: RuleListViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = false
        
        if self.ruleManager == nil, let file = self.fileManager.read("whitelist.json") {

            self.ruleManager = ContentBlockerRuleManager(data: file)
        }
    }
    
    
    func addButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("whitelistAddSegue", sender: nil)
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
     * Our view was deinitialized so we'll write the JSON back to the file
     * This saves us from writing it each time a change is made, and instead 
     * writes only when we exit this view
     *
     * @TODO Refactor this so that it's using a WhiteListEntity and BlockerListEntity
     *  to perform CRUD operations and abstract out the reloading and such
    */
    deinit {

        if let rawJSONString = self.ruleManager?.getRawJSONString() {
            self.fileManager.write("whitelist.json", fileContents: rawJSONString)
            
            if let mergedJSON = MergedRulesFileFactory.build() {
                self.fileManager.write("blockerList.json", fileContents: mergedJSON)
                SFContentBlockerManager.reloadContentBlockerWithIdentifier("com.francisbailey.Garden-Wall.ContentBlocker", completionHandler: nil)
            }
            
        }
    }
    
}


// MARK - UITableView DataSource
extension WhitelistViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if let title = rules?[indexPath.row].trigger.ifDomain?[0] {
        
            let formattedTitle = title.stringByReplacingOccurrencesOfString(
                WhitelistRuleFactory.whitelistItemPrefix, withString: ""
            )
            
            cell.textLabel?.text = formattedTitle
        }
        else {
            cell.textLabel?.text = "No Title"
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        return cell
    }
    
}


// MARK - UITableView Delegate
extension WhitelistViewController {
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        if section == 0 && ruleManager?.count() > 0 {
            
            return "Swipe left to remove a website."
        }
        
        return nil
    }
    
}
