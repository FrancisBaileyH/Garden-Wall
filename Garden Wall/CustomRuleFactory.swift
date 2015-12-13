//
//  CustomRuleFactory.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-07.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import Foundation



class CustomRuleFactory {
    
    
    struct fields {
        static let type             = "type"
        static let loadType         = "loadType"
        static let selector         = "selector"
        static let ifDomain         = "ifDomain"
        static let urlFilter        = "urlFilter"
        static let resourceType     = "resourceType"
        static let urlCaseSensitive = "urlCaseSensitive"
    }
    
    
    /*
     * Produce a content blocker rule from an NSDictionary of AnyObject: AnyObject
    */
    static func build(values: NSDictionary) -> ContentBlockerRule {
        
        var trigger = ContentBlockerRuleTrigger()
        var action  = ContentBlockerRuleAction()
        
        
        for (key, field) in values {
            
            switch (key as! String) {
                
                case fields.urlFilter:
                    trigger.urlFilter = field as? String
                    break
             
                case fields.urlCaseSensitive:
                    trigger.urlFilterIsCaseSensitive = field as? Bool
                    break
                
                case fields.loadType:

                    let transformer = FormEnumValueTransform<ContentBlockerRuleTriggerLoadType, String>()
                    
                    if let values = field as? [String] {
                    
                        trigger.loadType = transformer.transformFromFormValue(values)
                    }
                    break
                
                case fields.resourceType:
                    
                    let transformer = FormEnumValueTransform<ContentBlockerRuleTriggerResourceType, String>()
                    
                    if let values = field as? [String] {
                        
                        trigger.resourceType = transformer.transformFromFormValue(values)
                    }
                    break
                
                case fields.type:
                    if let type = field as? [String] {
                        if let rawValue = type.first {
                            action.type = ContentBlockerRuleActionType(rawValue: rawValue)
                        }
                    }
                    break
                
                case fields.selector:
                    action.selector = field as? String
                    break
                
                case fields.ifDomain:
                    
                    if let domains = field as? String {
                        
                        var values: [String] = [String]()
                        
                        for domain in domains.componentsSeparatedByString("\n") {
                            values.append(domain)
                        }
                        
                        if values.count > 0 {
                            trigger.ifDomain = values
                        }
                    }
                    
                    break
                
                default: break
            }
        }
        
        return ContentBlockerRule(trigger: trigger, action: action)
    }

}