//
//  CustomRuleViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-05.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//


import UIKit
import SafariServices



class CustomRuleViewController: RuleListViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelText = "No rules found. Press the plus sign to add a new rule."

        if ruleManager == nil, let file = fileManager.read("customList.json") {
            
            ruleManager = ContentBlockerRuleManager(data: file)
        }
    }
    
    
    func addButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("addCustomRuleSegue", sender: nil)
    }
    
    
    /*
     * Pass the ruleManager class to the presented view controller
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "addCustomRuleSegue" {
            
            let navController = segue.destinationViewController as! UINavigationController
            let controller    = navController.topViewController as! AddCustomRuleViewController
            
            controller.ruleManager = self.ruleManager
        }
    }
    
    
    /*
     * Our view was deinitialized so we'll write the JSON back to the file
     * This saves us from writing it each time a change is made, and instead
     * writes only when we exit this view
    */
    deinit {
        
        if let rawJSONString = self.ruleManager?.getRawJSONString() {
            self.fileManager.write("customList.json", fileContents: rawJSONString)
            
            if let mergedJSON = MergedRulesFileFactory.build() {
                self.fileManager.write("blockerList.json", fileContents: mergedJSON)
                SFContentBlockerManager.reloadContentBlockerWithIdentifier("com.francisbailey.Garden-Wall.ContentBlocker", completionHandler: nil)
            }
        }
    }
    
}


// MARK - UITableView DataSource
extension CustomRuleViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let title = rules![indexPath.row].trigger.urlFilter
        
        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = title
        
        return cell
    }
    
}


// MARK - UITableView Delegate
extension CustomRuleViewController {

    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        if section == 0 && ruleManager?.count() > 0 {
            
            return "Swipe left to remove a rule."
        }
        
        return nil
    }
}

