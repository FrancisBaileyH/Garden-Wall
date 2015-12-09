//
//  WhitelistRuleFactory.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-03.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import Foundation


class WhitelistRuleFactory {
    
    
    static func build(url: String) -> ContentBlockerRule {
        
        var action = ContentBlockerRuleAction()
        var trigger = ContentBlockerRuleTrigger()
        
        action.type = ContentBlockerRuleActionType.ignoreRules
        trigger.ifDomain = [url]
        trigger.urlFilter = ".*"
        
        return ContentBlockerRule(trigger: trigger, action: action)
    }
    
}