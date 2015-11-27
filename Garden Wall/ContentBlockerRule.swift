//
//  ContentBlockerRule.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-25.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import Foundation
import ObjectMapper



/*
 * An enumeration representing the possible type values in a rule action
*/
enum ContentBlockerRuleActionType: String {
    case block          = "block"
    case blockCookies   = "block-cookies"
    case cssDisplayNone = "css-display-none"
    case ignoreRules    = "ignore-previous-rules"
}


/*
 * An enumeration representing the possible load-type values in a rule trigger
*/
enum ContentBlockerRuleTriggerLoadType: String {
    case firstParty = "first-party"
    case thirdParty = "third-party"
}


/*
 * An enumeration representing the possible resource-type values in a rule trigger
*/
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


/*
 * A JSON Mappable entity that represents the Trigger part of a Content Blocker rule
*/
struct ContentBlockerRuleTrigger: Mappable {
    
    var urlFilter: String!
    var urlFilterIsCaseSensitive: Bool?
    var loadType: ContentBlockerRuleTriggerLoadType?
    var resourceType: ContentBlockerRuleTriggerResourceType?
    var ifDomain: String?
    
    
    init?(_ map: Map) { }


    init() { }
    
    
    init(urlFilter: String, urlCase: Bool?, loadType: ContentBlockerRuleTriggerLoadType?, resourceType: ContentBlockerRuleTriggerResourceType?, ifDomain: String?) {
        
        self.urlFilter = urlFilter
        self.urlFilterIsCaseSensitive = urlCase
        self.loadType = loadType
        self.resourceType = resourceType
        self.ifDomain = ifDomain
    }
    
    
    mutating func mapping(map: Map) {
        
        urlFilter                <- map["url-filter"]
        urlFilterIsCaseSensitive <- map["url-filter-is-case-sensitive"]
        loadType                 <- (map["load-type"], EnumTransform())
        resourceType             <- (map["resource-type"], EnumTransform())
        ifDomain                 <- map["if-domain"]
    }
}


/*
* A JSON Mappable entity that represents the Action part of a Content Blocker rule
*/
struct ContentBlockerRuleAction: Mappable {
    
    var type: ContentBlockerRuleActionType!
    var selector: String?
    
    
    init?(_ map: Map) { }
    
    
    init() { }
    
    
    init(type: ContentBlockerRuleActionType, selector: String?) {
        self.type = type
        self.selector = selector
    }
    
    
    mutating func mapping(map: Map) {
        
        type     <- (map["type"], EnumTransform())
        selector <- map["selector"]
    }
}


/*
 * A JSON Mappable entity that represents a Content Blocker Rule
*/
class ContentBlockerRule: Mappable {
    
    var action: ContentBlockerRuleAction!
    var trigger: ContentBlockerRuleTrigger!
    
    
    required init?(_ map: Map) { }
    
    
    init(action: ContentBlockerRuleAction, trigger: ContentBlockerRuleTrigger) {
        
        self.action = action
        self.trigger = trigger
    }
    
    
    func mapping(map: Map) {
        
        action <- map["action"]
        trigger <- map["trigger"]
    }
}

