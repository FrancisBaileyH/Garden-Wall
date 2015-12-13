//
//  AddWhitelistItemViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-03.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//


import UIKit
import SwiftForms



class AddWhitelistItemViewController: AddItemViewController {

    
    var ruleManager: ContentBlockerRuleManager?
    var fileManager: ContentBlockerFileManager?
    
    
    /*
     * Save the new rule and close the view, unless an error occurred
    */
    override func saveButtonPressed(sender: AnyObject) {
        
        let formData = self.form.formValues()

        if let url = formData["url"] as? String {
            
            if self.saveWhitelistItem(url) {
                self.cancelButtonPressed(sender)
            }
        }
    }
    
    
    func saveWhitelistItem(url: String) -> Bool {
        
        if NSURL(string: url) == nil {
            
            self.showAlert("Invalid URL.")
        }
        else {
            
            let rule   = WhitelistRuleFactory.build(url)
            let result = ruleManager?.create(rule)
            
            if result != nil && (result!) == false {
                self.showAlert("Whitelisted site already added.")
            }
            else {
                
                if let rawJSONString = self.ruleManager?.getRawJSONString() {
                    self.fileManager?.write("whitelist.json", fileContents: rawJSONString)
                    self.fileManager?.merge(MergedRulesFileFactory.build())
                }
                
                return true
            }
        }
        
        return false
    }
    
    
    /*
     * Insantiate the form object and generate fields to display
    */
    override func initializeForm() -> FormDescriptor {
        
        let form       = FormDescriptor()
        let section    = FormSectionDescriptor()
        let websiteUrl = FormRowDescriptor(tag: "url", rowType: FormRowType.URL, title: "URL")
        
        websiteUrl.configuration[FormRowDescriptor.Configuration.CellConfiguration] = [
            "textField.placeholder" : "e.g. www.example.com",
            "textField.textAlignment" : NSTextAlignment.Right.rawValue
        ]
        
        section.addRow(websiteUrl)
        
        form.sections = [ section ]
        
        return form
    }

}