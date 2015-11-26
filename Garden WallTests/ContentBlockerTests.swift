//
//  ContentBlockerTests.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-25.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import XCTest
import SwiftyJSON


class ContentBlockerTests: XCTestCase {

    var contentBlocker: ContentBlockerRuleManager?
    var existingRule: ContentBlockerRule?
    var newRule: ContentBlockerRule?
    
    
    
    override func setUp() {
        super.setUp()
        
        
        let bundle = NSBundle(forClass: ContentBlockerTests.self)
        let path = bundle.pathForResource("TestContentBlocker", ofType: "json")
        
        let jsonData = NSData(contentsOfFile: path!)

        
        contentBlocker = ContentBlockerRuleManager(json: JSON(data: jsonData!))
        
        
        let actionA = ContentBlockerRuleAction(type: ContentBlockerRuleActionType.block, selector: nil)
        
        var triggerA = ContentBlockerRuleTrigger()
        triggerA.loadType = ContentBlockerRuleTriggerLoadType.thirdParty
        triggerA.urlFilter = ".*"
        
        newRule = ContentBlockerRule(action: actionA, trigger: triggerA)
        
        
        var actionB = ContentBlockerRuleAction()
        actionB.type = ContentBlockerRuleActionType.block
        
        var triggerB = ContentBlockerRuleTrigger()
        triggerB.urlFilter = "evil-tracker\\.js"
    
        existingRule = ContentBlockerRule(action: actionB, trigger: triggerB)
    }
    
    
    
    func testGetIndexOf() {
        
        let existingJSONRule = contentBlocker?.convertRuleToJSON(existingRule!)
        let newJSONRule = contentBlocker?.convertRuleToJSON(newRule!)
        
        let existingIndex = contentBlocker?.getIndexOfRule(existingJSONRule!)
        let nonexistingIndex = contentBlocker?.getIndexOfRule(newJSONRule!)
        
        XCTAssertEqual(existingIndex, "1")
        XCTAssertNil(nonexistingIndex)
    }
    
    
    func testUpdateRule() {
        
        //let updatedRule =
        
        
    }
    
    
    func testDeleteRule() {
        
        contentBlocker?.delete(existingRule!)
        
        let jsonRule = contentBlocker?.convertRuleToJSON(existingRule!)
        let nonexistingIndex = contentBlocker?.getIndexOfRule(jsonRule!)
        
        XCTAssertNil(nonexistingIndex)
    }
    
    
    
    
    
}
