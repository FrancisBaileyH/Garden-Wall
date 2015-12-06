//
//  AddCustomRuleViewController.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-06.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//


import UIKit
import SwiftForms



class AddCustomRuleViewController: AddItemViewController {

    
    var ruleManager: ContentBlockerRuleManager?
    
    
    override func initializeForm() -> FormDescriptor {
        
        let form = FormDescriptor()
        
        
        let triggerSection   = FormSectionDescriptor()
        
        let urlFilter        = FormRowDescriptor(tag: "urlFilter", rowType: FormRowType.Text, title: "URL Filter")
        let urlCaseSensitive = FormRowDescriptor(tag: "urlCaseSensitive", rowType: FormRowType.BooleanCheck, title: "URL Filter is Case Sensitive")
        let loadType         = FormRowDescriptor(tag: "loadType", rowType: FormRowType.MultipleSelector, title: "Load Type")
        let resourceType     = FormRowDescriptor(tag: "resourceType", rowType: FormRowType.MultipleSelector, title: "Resource Type")
        
        triggerSection.headerTitle = "Trigger"
        triggerSection.addRow(urlFilter)
        triggerSection.addRow(urlCaseSensitive)
        triggerSection.addRow(loadType)
        triggerSection.addRow(resourceType)
        
        
        let actionSection    = FormSectionDescriptor()
        
        let actionType = FormRowDescriptor(tag: "type", rowType: FormRowType.Picker, title: "Type")
        
        actionType.configuration[FormRowDescriptor.Configuration.Options] = ["F", "M", "U"]
        actionType.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
            switch( value ) {
            case "F":
                return "Block"
            case "M":
                return "Block Cookies"
            case "U":
                return "Ignore Previous Rules"
            default:
                return nil
            }
            } as TitleFormatterClosure
        
        let selector   = FormRowDescriptor(tag: "selector", rowType: FormRowType.Text, title: "CSS Selector")
        
        actionSection.headerTitle = "Action"
        actionSection.addRow(actionType)
        actionSection.addRow(selector)
        
        
        form.title = "Custom Rule"
        form.sections = [ triggerSection, actionSection ]
        
//        var urlFilter: String!
//        var urlFilterIsCaseSensitive: Bool?
//        var loadType: ContentBlockerRuleTriggerLoadType?
//        var resourceType: ContentBlockerRuleTriggerResourceType?
//        var ifDomain: String?
        
//        var type: ContentBlockerRuleActionType!
//        var selector: String?

        
        return form
    }

}