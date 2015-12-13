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
        
        self.labelText = "Press the plus sign to add a new rule."

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
            controller.fileManager = self.fileManager
            
            if let index = sender as? Int {
                controller.customRule = self.ruleManager?.fetch(index)
                controller.customRuleIndex = index
            }
        }
    }
    
    
}


// MARK - UITableView DataSource
extension CustomRuleViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let title = rules![indexPath.row].trigger.urlFilter
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomRuleCell", forIndexPath: indexPath)
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
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("addCustomRuleSegue", sender: indexPath.row)

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        super.tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
        
        if editingStyle == .Delete {
            
            if let rawJSONString = self.ruleManager?.getRawJSONString() {
                self.fileManager.write("customList.json", fileContents: rawJSONString)
                self.fileManager.merge(MergedRulesFileFactory.build())
            }

        }
    }
}

