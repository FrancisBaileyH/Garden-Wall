//
//  ContentBlockerRule.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-25.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import Foundation


enum ContentBlockerRuleActionType: String {
    case block          = "block"
    case blockCookies   = "block-cookies"
    case cssDisplayNone = "css-display-none"
    case ignoreRules    = "ignore-previous-rules"
}


enum ContentBlockerRuleTriggerLoadType: String {
    case firstParty = "first-party"
    case thirdParty = "third-party"
}


enum ContentBlockerRuleTriggerResourceType: String {
    case document   = "document"
    case font       = "font"
    case image      = "image"
    case media      = "media"
    case popup      = "popup"
    case raw        = "raw"
    case script     = "script"
    case styleSheet = "style-sheet"
    case svgDoc     = "svg-document"
}


struct ContentBlockerRuleTrigger {
    var urlFilter: String
    var urlFilterIsCaseSensitive: Bool?
    var loadType: ContentBlockerRuleTriggerLoadType?
    var resourceType: ContentBlockerRuleTriggerResourceType?
    var ifDomain: String?
}


struct ContentBlockerRuleAction {
    var type: ContentBlockerRuleActionType
    var selector: String?
}


class ContentBlockerRule {
    
    private var action: ContentBlockerRuleAction
    private var trigger: ContentBlockerRuleTrigger
    
    
    init (action: ContentBlockerRuleAction, trigger: ContentBlockerRuleTrigger) {
        self.action = action
        self.trigger = trigger
    }
    
    
    func setTrigger(trigger: ContentBlockerRuleTrigger) {
        self.trigger = trigger
    }
    
    
    func setAction(action: ContentBlockerRuleAction) {
        self.action = action
    }
    
    
    func getAction() -> ContentBlockerRuleAction {
        return self.action
    }
    
    
    func getTrigger() -> ContentBlockerRuleTrigger {
        return self.trigger
    }
    
    
}