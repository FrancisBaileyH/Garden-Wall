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
        static let urlFilter: String = "urlFilter"
        static let urlCaseSensitive = "urlCaseSensitive"
        static let loadType = "loadType"
        static let resourceType = "resourceType"
        static let type = "type"
        static let selector = "selector"
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
                    /* @TODO use a transform to convert array of strings to array of enums
                    */
                    
                    trigger.loadType = field as? [ContentBlockerRuleTriggerLoadType]
                    break
                
                case fields.resourceType:
                    trigger.resourceType = field as? [ContentBlockerRuleTriggerResourceType]
                    break
                
                case fields.type:
                    if let type = field as? String {
                        action.type = ContentBlockerRuleActionType(rawValue: type)
                    }
                    break
                
                case fields.selector:
                    action.selector = field as? String
                    break
                
                default: break
            }
        }
        
        return ContentBlockerRule(trigger: trigger, action: action)
    }

}