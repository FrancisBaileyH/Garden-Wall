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
    //private var writer:
    
    // writer.write(JSON)
    init(json: JSON) {
        self.json = json
    }
    
    
    func create(rule: ContentBlockerRule) {

        
        
    }
    
    
    /*
     * Search for and delete a given rul in the content blocker JSON
    */
    func delete(rule: ContentBlockerRule) {

        let jsonRule = convertRuleToJSON(rule)
        
        if let index = getIndexOfRule(jsonRule) {
            self.json.dictionaryObject?.removeValueForKey(index)
        }
    }
    
    
    /*
     * Update a rule a given rule in the content blocker JSON
    */
    func update(rule: ContentBlockerRule) {
        
        let jsonRule = convertRuleToJSON(rule)
        
        if let index = getIndexOfRule(jsonRule) {
            
            self.json[index] = jsonRule
        }
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
    func getIndexOfRule(rule: JSON) -> String? {
        
        NSLog("Called")
        
        for (key, value):(String, JSON) in self.json {
            
            NSLog("\(value)")
            
            if value == rule {
                return key
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
