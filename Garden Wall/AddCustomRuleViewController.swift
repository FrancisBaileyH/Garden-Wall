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
    
    
    struct fields {
        static let urlFilter        = "urlFilter"
        static let urlCaseSensitive = "urlCaseSensitive"
        static let loadType         = "loadType"
        static let resourceType     = "resourceType"
        static let type             = "type"
        static let selector         = "selector"
    }
    
    
    override func saveButtonPressed(sender: AnyObject) {
        
        self.form.formValues()
        let rule = CustomRuleFactory.build(self.form.formValues())
        self.ruleManager?.create(rule)
        
        self.cancelButtonPressed(sender)
    }
    
    
    override func initializeForm() -> FormDescriptor {
        
        let form = FormDescriptor()
        
        
        let triggerSection   = FormSectionDescriptor()
        
        let urlFilter        = FormRowDescriptor(tag: CustomRuleFactory.fields.urlFilter, rowType: FormRowType.Text, title: "URL Filter")
        let urlCaseSensitive = FormRowDescriptor(tag: CustomRuleFactory.fields.urlCaseSensitive, rowType: FormRowType.BooleanCheck, title: "URL Filter is Case Sensitive")
        let loadType         = FormRowDescriptor(tag: CustomRuleFactory.fields.loadType, rowType: FormRowType.MultipleSelector, title: "Load Type")
        
        loadType.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = true
        loadType.configuration[FormRowDescriptor.Configuration.Options] = [
            ContentBlockerRuleTriggerLoadType.firstParty.rawValue,
            ContentBlockerRuleTriggerLoadType.thirdParty.rawValue
        ]
        
        let resourceType = FormRowDescriptor(tag: CustomRuleFactory.fields.resourceType, rowType: FormRowType.MultipleSelector, title: "Resource Type")
        
        resourceType.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = true
        resourceType.configuration[FormRowDescriptor.Configuration.Options] = [
            ContentBlockerRuleTriggerResourceType.document.rawValue,
            ContentBlockerRuleTriggerResourceType.font.rawValue,
            ContentBlockerRuleTriggerResourceType.image.rawValue,
            ContentBlockerRuleTriggerResourceType.media.rawValue,
            ContentBlockerRuleTriggerResourceType.popup.rawValue,
            ContentBlockerRuleTriggerResourceType.raw.rawValue,
            ContentBlockerRuleTriggerResourceType.script.rawValue,
            ContentBlockerRuleTriggerResourceType.styleSheet.rawValue,
            ContentBlockerRuleTriggerResourceType.svgDoc.rawValue
        ]
        
        triggerSection.headerTitle = "Trigger"
        triggerSection.addRow(urlFilter)
        triggerSection.addRow(urlCaseSensitive)
        triggerSection.addRow(loadType)
        triggerSection.addRow(resourceType)
    
        
        let actionSection = FormSectionDescriptor()
        
        let actionType    = FormRowDescriptor(tag: CustomRuleFactory.fields.type, rowType: FormRowType.Picker, title: "Type")
        
        actionType.configuration[FormRowDescriptor.Configuration.Options] = [
            ContentBlockerRuleActionType.block.rawValue,
            ContentBlockerRuleActionType.blockCookies.rawValue,
            ContentBlockerRuleActionType.cssDisplayNone.rawValue,
            ContentBlockerRuleActionType.ignoreRules.rawValue
        ]
        
        let selector   = FormRowDescriptor(tag: CustomRuleFactory.fields.selector, rowType: FormRowType.Text, title: "CSS Selector")
        
        actionSection.headerTitle = "Action"
        actionSection.addRow(actionType)
        actionSection.addRow(selector)
        
        
        form.title = "Custom Rule"
        form.sections = [ triggerSection, actionSection ]
        
        
        return form
    }

}