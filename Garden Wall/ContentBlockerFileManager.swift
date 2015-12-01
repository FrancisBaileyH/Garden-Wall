//
//  ContentBlockerFileManager.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-30.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import Foundation
import SwiftyJSON



class ContentBlockerFileManager {
    
    
    
    static func readJSONFile(filename: String) -> JSON? {
        
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
        
            let jsonData = NSData(contentsOfFile: path)
        
            if let data = jsonData {
                return JSON(data)
            }
        }
        
        return nil
    }
    
    
    static func writeJSONFile(filename: String, fileContents: String) -> Bool {
        
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
        
            do {
                try fileContents.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
                return true
            }
            catch {    }
        }
    
        return false
    }
    
}