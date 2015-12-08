//
//  ViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-25.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//


import UIKit
import GBVersionTracking



class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var buildLabel: UILabel!
    
    
    
    let menu = [ ["Enable Adblocking"], ["Manage Whitelisted Websites", "Advanced Configuration", "View Blocker List"] ]
    
    
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
        
        buildLabel.text = "Version " + GBVersionTracking.currentVersion()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
     * Configure basic table layout and view settings
    */
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 20
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine;
        
        return menu.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu[section].count
    }
    
    
    /*
     * Initialize Menu Item Cells
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell", forIndexPath: indexPath)
        
        
        if indexPath.section == 0 && indexPath.row == 0 {
        
            let cellSwitch = UISwitch(frame: CGRectZero) as UISwitch
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryView = cellSwitch
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        cell.textLabel!.text = menu[indexPath.section][indexPath.row]

        
        return cell
    }
    
    
    /*
     * Show new controller based on which menu item was selected
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
        switch indexPath.section {
            
            case 0:
                
                break
            
            case 1:
                handleMenuSectionAction(indexPath.row)
                break
            
            default:
            
            break
            
        }
    }
    
    
    /*
     * Handle a menu item selection and segue to corresponding view
    */
    func handleMenuSectionAction(row: Int) {
        
        var segueId: String?
        
        switch row {
            
            case 0:
                segueId = "whitelistManagementSegue"
                break
            
            case 1:
                segueId = "advancedManagementSegue"
                break
            
            case 2:
                segueId = "fileViewerSegue"
                break
            
            default:
                segueId = nil
            
        }
        
        if let id = segueId {
            self.performSegueWithIdentifier(id, sender: nil)
        }
    }
}

