//
//  ContentBlocker.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-25.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper



class ContentBlockerRuleManager {
    
    
    private var json: JSON

    
    init(json: JSON) {
        self.json = json
    }
    
    
    /*
     * Create a rule if the rule does not exist yet, otherwise return false
    */
    func create(rule: ContentBlockerRule) -> Bool {
        
        let jsonRule = convertRuleToJSON(rule)
        
        if getIndexOfRule(jsonRule) == nil {
        
            let jsonRule = convertRuleToJSON(rule)

            if let _ = (self.json.arrayObject?.count) {
                self.json.arrayObject?.append(jsonRule.rawValue)
                return true
            }
        }
        
        return false
    }
    
    
    /*
     * Search for and delete a given rule in the content blocker JSON
    */
    func delete(rule: ContentBlockerRule) {

        let jsonRule = convertRuleToJSON(rule)
        
        if let index = getIndexOfRule(jsonRule) {
            self.json.arrayObject?.removeAtIndex(index)
        }
    }
    
    
    /*
     * Update a rule a given rule in the content blocker JSON
    */
    func update(index: Int, rule: ContentBlockerRule) {
        
        let jsonRule = convertRuleToJSON(rule)
        
        if self.json[index].isExists() {
            
            self.json[index] = jsonRule
        }
    }
    
    
    /*
     * Retrieve a rule from the JSON if it exists
    */
    func fetch(index: Int) -> ContentBlockerRule? {
        
        if let jsonRule = self.json[index].rawString() {
        
            if let rule = Mapper<ContentBlockerRule>().map(jsonRule) {
                
                return rule
            }
        }
        
        return nil
    }
    
    
    /*
     * Function to convert a ContentBlockerRule object into a JSON object
    */
    internal func convertRuleToJSON(rule: ContentBlockerRule) -> JSON {
        
        let mapperString = Mapper().toJSONString(rule, prettyPrint: true)
        
        if let jsonString = mapperString {
        
            if let dataFromString = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                
                return JSON(data: dataFromString)
            }
        }

        return JSON(data: NSData())
    }
    
    
    /*
     * Fetch the index of a rule if it exists in the JSON object
    */
    func getIndexOfRule(rule: JSON) -> Int? {
        
        for (index, value):(String, JSON) in self.json {
            
            if value == rule {
                return Int(index)
            }
        }
        
        return nil
    }
    
    
    func getJSON() -> JSON {
        return self.json
    }
    
    
    func getJSONString() -> String? {
        return self.json.rawString()
    }

    
}
