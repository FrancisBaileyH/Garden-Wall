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
        self.labelText = "Press the plus sign to add a new site."
        
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
            controller.fileManager = self.fileManager
        }
    }
    
}


// MARK - UITableView DataSource
extension WhitelistViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("WhitelistRuleCell", forIndexPath: indexPath)
        
        if let trigger = rules?[indexPath.row].trigger, let title = trigger.ifDomain?[0] {
            
            cell.textLabel?.text = title
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
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
        super.tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
        
        if editingStyle == .Delete {

            if let rawJSONString = self.ruleManager?.getRawJSONString() {
                self.fileManager.write("whitelist.json", fileContents: rawJSONString)
                self.fileManager.merge(MergedRulesFileFactory.build())
            }
        }
    }
    
}
