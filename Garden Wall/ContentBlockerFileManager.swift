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
    
    
    private var groupUrl: NSURL
    private var fileManager: NSFileManager
    
    
    static let sharedInstance = ContentBlockerFileManager()
    
    
    
    init() {
        
        fileManager = NSFileManager.defaultManager()
        groupUrl    = fileManager.containerURLForSecurityApplicationGroupIdentifier("group.com.fbailey.garden-wall")!
    }
    
    
    
    
    func readJSONFile(filename: String) -> JSON? {
        
        NSLog("\(groupUrl)")
        
        let enumerator: NSDirectoryEnumerator? = fileManager.enumeratorAtURL(groupUrl, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions(), errorHandler: nil)
        
        while let element = enumerator?.nextObject() as? String {
            NSLog(element)
        }
        
        
        
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
        
            let jsonData = NSData(contentsOfFile: path)
        
            if let data = jsonData {
                return JSON(data)
            }
        }
        
        return nil
    }
    
    
    func writeJSONFile(filename: String, fileContents: String) -> Bool {
        
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