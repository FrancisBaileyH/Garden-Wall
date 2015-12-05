//
//  AddWhitelistItemViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-03.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import UIKit
import SwiftForms



class AddWhitelistItemViewController: FormViewController {

    
    var ruleManager: ContentBlockerRuleManager?
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeForm()
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
        
        let formData = self.form.formValues()

        if let url = formData["url"] as? String {

            let rule   = WhitelistRuleFactory.build(url)
            let result = ruleManager?.create(rule)
            
            if result != nil && (result!) == false {
                self.showAlert("Whitelisted site already added.")
            }
            else {
                self.cancelButtonPressed(sender)
            }
        }
    }
    
    
    /*
     * Insantiate the form object and generate fields to display
    */
    func initializeForm() {
        
        let form       = FormDescriptor()
        let section    = FormSectionDescriptor()
        let websiteUrl = FormRowDescriptor(tag: "url", rowType: FormRowType.URL, title: "URL")
        
        websiteUrl.configuration[FormRowDescriptor.Configuration.CellConfiguration] = [
            "textField.placeholder" : "e.g. www.example.com",
            "textField.textAlignment" : NSTextAlignment.Right.rawValue
        ]
        
        section.addRow(websiteUrl)
        
        form.sections = [ section ]
        
        self.form = form
    }
    
    
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

}