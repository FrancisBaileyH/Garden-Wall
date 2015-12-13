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
    var fileManager: ContentBlockerFileManager?
    var customRule: ContentBlockerRule?
    var customRuleIndex: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.form = self.initializeForm()
    }
    
    
    func deleteButtonPressed() {
        
        if let rule = self.customRule {
            self.ruleManager?.delete(rule)
            self.updateAction()
            self.cancelButtonPressed(self)
        }
        
    }
    
        
    override func saveButtonPressed(sender: AnyObject) {
        
        let rule = CustomRuleFactory.build(self.form.formValues())
        
        if self.validate(rule) {
        
            if customRule != nil, let index = customRuleIndex {
                self.ruleManager?.update(index, rule: rule)
            }
            else {
                self.ruleManager?.create(rule)
            }
        
            self.updateAction()
            self.cancelButtonPressed(sender)
        }
    }
    
    
    /*
     * Run any time an update action occurs on the rule
    */
    func updateAction() {
        
        if let rawJSONString = self.ruleManager?.getRawJSONString() {
            self.fileManager?.write("customList.json", fileContents: rawJSONString)
            self.fileManager?.merge(MergedRulesFileFactory.build())
        }
    }
    
    
    func validate(rule: ContentBlockerRule) -> Bool {
        
        var result: Bool = true
        var message: String = ""
        
        if rule.trigger.urlFilter == nil {
            result = false
            message += "URL Filter must not be empty\n"
        }
        
        if rule.action.type == nil {
            result = false
            message += "Action type cannnot be empty \n"
        }
        else if rule.action.type == ContentBlockerRuleActionType.cssDisplayNone && rule.action.selector == nil {
            result = false
            message += "If css-display-none is selected, it must have an accompanying selector\n"
        }
        
        if !result {
            self.showAlert(message)
        }
        
        return result
    }
    
    
    override func initializeForm() -> FormDescriptor {
        
        let form = FormDescriptor()
        
        let textFieldSettings = ["textField.textColor": UIColor.lightGrayColor() ,"textField.textAlignment" : NSTextAlignment.Right.rawValue]
        
        
        let triggerSection   = FormSectionDescriptor()
        let actionSection    = FormSectionDescriptor()
        
        let loadTypeTransformer = FormEnumValueTransform<ContentBlockerRuleTriggerLoadType, String>()
        let resTypeTransformer  = FormEnumValueTransform<ContentBlockerRuleTriggerResourceType, String>()
        let actTypeTransformer  = FormEnumValueTransform<ContentBlockerRuleActionType, String>()
        
        
        let urlFilter        = FormRowDescriptor(
            tag: CustomRuleFactory.fields.urlFilter,
            rowType: FormRowType.Text,
            title: "URL Filter"
        )
        urlFilter.configuration[FormRowDescriptor.Configuration.CellConfiguration] = textFieldSettings
        
        
        let urlCaseSensitive = FormRowDescriptor(
            tag: CustomRuleFactory.fields.urlCaseSensitive,
            rowType: FormRowType.BooleanCheck,
            title: "URL Filter is Case Sensitive"
        )
        
        
        let loadType         = FormRowDescriptor(
            tag: CustomRuleFactory.fields.loadType,
            rowType: FormRowType.MultipleSelector,
            title: "Load Type"
        )
        loadType.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = true
        loadType.configuration[FormRowDescriptor.Configuration.Options] = loadTypeTransformer.transformToFormValue()
        
        
        let resourceType = FormRowDescriptor(
            tag: CustomRuleFactory.fields.resourceType,
            rowType: FormRowType.MultipleSelector,
            title: "Resource Type"
        )
        resourceType.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = true
        resourceType.configuration[FormRowDescriptor.Configuration.Options] = resTypeTransformer.transformToFormValue()
        
        
        let ifDomains = FormRowDescriptor(
            tag: CustomRuleFactory.fields.ifDomain,
            rowType: FormRowType.MultilineText,
            title: "If Domains"
        )
        
        
        let actionType = FormRowDescriptor(
            tag: CustomRuleFactory.fields.type,
            rowType: FormRowType.MultipleSelector,
            title: "Type"
        )
        actionType.configuration[FormRowDescriptor.Configuration.Options] = actTypeTransformer.transformToFormValue()
        
        
        let selector = FormRowDescriptor(
            tag: CustomRuleFactory.fields.selector,
            rowType: FormRowType.Text,
            title: "CSS Selector"
        )
        selector.configuration[FormRowDescriptor.Configuration.CellConfiguration] = textFieldSettings
        
        
        actionSection.headerTitle  = "Action"
        triggerSection.headerTitle = "Trigger"
        triggerSection.footerTitle = "Enter one domain per line."
        
        if let rule = self.customRule {

            selector.value         = rule.action.selector
            urlFilter.value        = rule.trigger.urlFilter
            actionType.value       = [rule.action.type.rawValue]
            ifDomains.value        = rule.trigger.ifDomain?.joinWithSeparator("\n")
            loadType.value         = loadTypeTransformer.transformToFormValue(rule.trigger.loadType)
            resourceType.value     = resTypeTransformer.transformToFormValue(rule.trigger.resourceType)
            urlCaseSensitive.value = rule.trigger.urlFilterIsCaseSensitive
        }
        
        
        actionSection.addRow(actionType)
        actionSection.addRow(selector)
        triggerSection.addRow(urlFilter)
        triggerSection.addRow(urlCaseSensitive)
        triggerSection.addRow(loadType)
        triggerSection.addRow(resourceType)
        triggerSection.addRow(ifDomains)
        
        
        form.title = "Custom Rule"
        form.sections = [ triggerSection, actionSection ]
        
        if self.customRule != nil {
            
            let section   = FormSectionDescriptor()
            let deleteBtn = FormRowDescriptor(tag: "delete", rowType: FormRowType.Button, title: "Delete")
            
            deleteBtn.configuration[FormRowDescriptor.Configuration.DidSelectClosure] = {
                
                self.deleteButtonPressed()
                
            } as DidSelectClosure
            
            section.addRow(deleteBtn)
            form.addSection(section)
        }
        
        
        return form
    }


}