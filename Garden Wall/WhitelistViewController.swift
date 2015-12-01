//
//  WhitelistViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-30.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import UIKit


class WhitelistViewController: UITableViewController {
    

    var ruleManager: ContentBlockerRuleManager!
    var rules: [ContentBlockerRule]?
    
    
    override func viewWillAppear(animated: Bool) {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonPressed:")

        self.navigationItem.rightBarButtonItem = addButton
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let file = ContentBlockerFileManager.readJSONFile("blockerList")
        ruleManager = ContentBlockerRuleManager(json: file!)
        rules = ruleManager.fetchAll()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func addButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("whitelistAddSegue", sender: nil)
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return ruleManager.count()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = rules?[indexPath.row].trigger.urlFilter
        
        return cell
    }
    
    
    
    
    
}
