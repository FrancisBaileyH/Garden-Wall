//
//  AddItemViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-06.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//


import UIKit
import SwiftForms



class AddItemViewController: FormViewController {
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.form = self.initializeForm()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonPressed:")
        let saveButton   = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "saveButtonPressed:")
        
        self.navigationItem.leftBarButtonItem  = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
    * Handle cancel button action
    */
    func cancelButtonPressed(sender: AnyObject) {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
    * Save the new rule and close the view, unless an error occurred
    */
    func saveButtonPressed(sender: AnyObject) {
        self.cancelButtonPressed(sender)
    }
    
    
    func initializeForm() -> FormDescriptor {
        return FormDescriptor()
    }
    

    func showAlert(message: String) {
        
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
}
