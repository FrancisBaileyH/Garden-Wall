//
//  MergedRulesFileFactory.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-07.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import Foundation
import SwiftyJSON


class MergedRulesFileFactory {
    
    
    static func build() -> String? {
        
        let fileManager = ContentBlockerFileManager()
        
        if let whitelist = fileManager.read("whitelist.json"),
           let customList = fileManager.read("customList.json"),
           let blockerListPath = NSBundle.mainBundle().pathForResource("blockerList", ofType: "json"),
           let blockerList = NSData(contentsOfFile: blockerListPath) {
                
            let contentBlocker = ContentBlockerRuleManager(data: customList)
            
            contentBlocker.merge(JSON(data: whitelist))
            contentBlocker.merge(JSON(data: blockerList))
            
            
            return contentBlocker.getRawJSONString()
        }
        
        return nil
    }
    
    
}