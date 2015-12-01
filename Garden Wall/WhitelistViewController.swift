//
//  WhitelistViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-30.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import UIKit


class WhitelistViewController: UITableViewController {
    

    
    override func viewWillAppear(animated: Bool) {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonPressed:")

        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func addButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("whitelistAddSegue", sender: nil)
    }
    
    
    
    
    
}
