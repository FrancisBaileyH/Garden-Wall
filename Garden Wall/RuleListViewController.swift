//
//  ItemListViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-05.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//


import UIKit



class RuleListViewController: UITableViewController {
    
    
    var fileManager: ContentBlockerFileManager = ContentBlockerFileManager.sharedInstance
    var ruleManager: ContentBlockerRuleManager?
    var rules:      [ContentBlockerRule]?
    var labelText:   String = "No Data Found."
    
    
    override func viewWillAppear(animated: Bool) {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonPressed:")
        self.navigationItem.rightBarButtonItem = addButton
        
        self.rules = ruleManager?.fetchAll()
        self.tableView.reloadData()
    }
    
    
    /*
     * Return the number of rules in the whitelist.json file
     * Set the background with a message if no rules exist
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = self.ruleManager?.count() {
            
            if count == 0 {
                tableView.backgroundView = self.createLabelView(tableView, message: self.labelText)
                tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            }
            else {
                tableView.backgroundView = nil
                tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            }
            
            return count
        }
        
        return 0
    }
    
    
    /*
     * Allow rows to register a swipe to delete action
    */
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    /*
     * Handle delete action on the table
    */
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            if let rule = self.ruleManager?.fetch(indexPath.row) {
                self.ruleManager?.delete(rule)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
                
                if tableView.numberOfRowsInSection(0) < 1 {
                    tableView.footerViewForSection(0)?.removeFromSuperview()
                }
            }
        }
    }
    

    func createLabelView(tableView: UITableView, message: String) -> UILabel {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height))
        
        label.text = message
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 4
        
        return label
    }
}
