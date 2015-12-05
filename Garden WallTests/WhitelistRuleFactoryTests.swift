//
//  WhitelistFactoryTest.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-03.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import XCTest
import SwiftyJSON


class WhitelistRuleFactoryTests: XCTestCase {
    
    
    var comparisonRule: JSON!
    var ruleManager: ContentBlockerRuleManager!
    
    
    override func setUp() {
        super.setUp()
        
        let bundle   = NSBundle(forClass: WhitelistRuleFactoryTests.self)
        let path     = bundle.pathForResource("TestWhitelist", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        
        
        ruleManager = ContentBlockerRuleManager(data: NSData())
        
        comparisonRule = JSON(data: jsonData!)
        NSLog("\(comparisonRule.error)")
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testBuildRule() {
        
        let url = "www.test.com"
        
        let rule = WhitelistRuleFactory.build(url)
        
        let json = ruleManager.convertRuleToJSON(rule)
        
        XCTAssertEqual(json.rawString(), comparisonRule.rawString())
    }
    
    
}
