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

    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initializeForm()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonPressed:")
        
        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "saveButtonPressed:")
        
        self.navigationItem.leftBarButtonItem = cancelButton
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
     * Handle save button action
    */
    func saveButtonPressed(sender: AnyObject) {
        
    }
    
    
    /*
     * Insantiate the form object and generate fields to display
    */
    func initializeForm() {
        
        let form       = FormDescriptor()
        let section    = FormSectionDescriptor()
        let websiteUrl = FormRowDescriptor(tag: "website", rowType: FormRowType.URL, title: "URL")
        
        websiteUrl.configuration[FormRowDescriptor.Configuration.CellConfiguration] = [
            "textField.placeholder" : "e.g. www.example.com",
            "textField.textAlignment" : NSTextAlignment.Right.rawValue
        ]
        
        section.addRow(websiteUrl)
        
        form.sections = [ section ]
        
        self.form = form
    }
    

}