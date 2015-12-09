//
//  ContentBlockerTests.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-25.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import XCTest
import SwiftyJSON
import ObjectMapper


class ContentBlockerTests: XCTestCase {

    var contentBlocker: ContentBlockerRuleManager?
    var existingJSONRule: JSON?
    var newJSONRule: JSON?
    var newRule: ContentBlockerRule?
    var existingRule: ContentBlockerRule?
    
    
    
    override func setUp() {
        super.setUp()
        
        let bundle   = NSBundle(forClass: ContentBlockerTests.self)
        let path     = bundle.pathForResource("TestContentBlocker", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)

        contentBlocker = ContentBlockerRuleManager(json: JSON(data: jsonData!))
        
        setupExistingRule()
        setupNewRule()
    }
    
    
    
    func testGetIndexOf() {
        
        let existingIndex    = contentBlocker?.getIndexOfRule(existingJSONRule!)
        let nonexistingIndex = contentBlocker?.getIndexOfRule(newJSONRule!)
        
        XCTAssertEqual(existingIndex, 1)
        XCTAssertNil(nonexistingIndex)
    }
    
    
    func testUpdateRule() {
        
        let rule          = contentBlocker?.fetch(0)
        rule?.action.type = ContentBlockerRuleActionType.blockCookies
        
        contentBlocker?.update(0, rule: rule!)
        
        let updatedRule   = contentBlocker?.fetch(0)
        
        XCTAssertEqual(rule!.action.type, updatedRule!.action.type)
    }
    
    
    func testFetchRule() {
        
        let index = contentBlocker?.getIndexOfRule(existingJSONRule!)
        let rule  = contentBlocker?.fetch(index!)

        XCTAssertNotNil(rule)
    }
    
    
    func testCreateRule() {
        
        contentBlocker?.create(newRule!)
        let result: Bool = (contentBlocker?.create(existingRule!))!
        
        let index = contentBlocker?.getIndexOfRule(newJSONRule!)

        XCTAssertNotNil(index)
        XCTAssertFalse(result)
    }
    
    
    func testDeleteRule() {
        
        contentBlocker?.delete(existingRule!)
        
        let index = contentBlocker?.getIndexOfRule(existingJSONRule!)
        
        XCTAssertNil(index)
    }
    
    
    func setupExistingRule() {
        
        var action        = ContentBlockerRuleAction()
        action.type       = ContentBlockerRuleActionType.block
        
        var trigger       = ContentBlockerRuleTrigger()
        trigger.urlFilter = "evil-tracker\\.js"
        
        existingRule      = ContentBlockerRule(trigger: trigger, action: action)
        existingJSONRule  = contentBlocker?.convertRuleToJSON(existingRule!)
    }
    
    
    func setupNewRule() {
        
        var action        = ContentBlockerRuleAction()
        action.type       = ContentBlockerRuleActionType.block
        
        var trigger       = ContentBlockerRuleTrigger()
        trigger.loadType  = [ContentBlockerRuleTriggerLoadType.thirdParty]
        trigger.urlFilter = ".*"
        
        newRule           = ContentBlockerRule(trigger: trigger, action: action)
        newJSONRule       = contentBlocker?.convertRuleToJSON(newRule!)
    }
    
    
    
    
}
