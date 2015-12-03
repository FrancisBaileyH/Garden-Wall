//
//  ViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-25.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let menu = [ "Manage Whitelisted Websites", "Advanced Configuration", "About" ]
    
    
    /*
     * Hide the navigation bar on the Home View only
    */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel!.text = menu[indexPath.row]

        
        return cell
    }
    
    
    /*
     * Show new controller based on which menu item was selected
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
        var segueId: String?
        
        switch indexPath.row {
            
            case 0:
                segueId = "whitelistManagementSegue"
                break
            
            case 1:
                segueId = "advancedManagementSegue"
                break
            
            case 2:
                segueId = "aboutSegue"
            
            default:
                segueId = nil

        }
        
        if let id = segueId {
            self.performSegueWithIdentifier(id, sender: nil)
        }
    }
    
}

