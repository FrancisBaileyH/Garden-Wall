//
//  ViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-25.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//


import UIKit
import GBVersionTracking


class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var buildLabel: UILabel!
    
    
    
    let menu = [ ["Enable Adblocking"], ["Manage Whitelisted Websites", "Manage Custom Rules", "View Blocker List"] ]
    
    
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
    
    
    func showSettingsPopup() {
        
        let alert = UIAlertController(title: nil, message: "Enable ad blocking by pressing \"Go to Settings\" and navigating to Safari → Content Blockers and enabling Garden Wall.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Go to Settings", style: UIAlertActionStyle.Default, handler:  { (_) -> Void in
            
            let settingsUrl = NSURL(string: "prefs:root=Safari")
            
            if let url = settingsUrl {
                UIApplication.sharedApplication().openURL(url)
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}


extension HomeViewController: UITableViewDelegate {
    
    
    /*
    * Show new controller based on which menu item was selected
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section {
            
        case 0:
            // open safari popup
            showSettingsPopup()
            break
            
        case 1:
            handleMenuSectionAction(indexPath.row)
            break
            
        default:
            
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menu[section].count
    }
    
    
    /*
     * Configure basic table layout and view settings
    */
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 20
    }
    
}


extension HomeViewController: UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine;
        
        return menu.count
    }
    
    
    /*
     * Initialize Menu Item Cells
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell", forIndexPath: indexPath)

        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel!.text = menu[indexPath.section][indexPath.row]
        
        
        return cell
    }
    
}

