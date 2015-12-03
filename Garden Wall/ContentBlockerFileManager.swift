//
//  ContentBlockerFileManager.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-11-30.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import Foundation


class ContentBlockerFileManager {
    
    
    private var groupUrl: NSURL
    private var fileManager: NSFileManager
    
    
    static let sharedInstance = ContentBlockerFileManager()
    
    
    
    init() {
        
        fileManager = NSFileManager.defaultManager()
        groupUrl    = fileManager.containerURLForSecurityApplicationGroupIdentifier("group.com.fbailey.garden-wall")!
    }
    
    
    func fileExists(filename: String) -> Bool {
        
        if let url = NSURL(string: filename, relativeToURL: groupUrl) {
        
            if url.checkResourceIsReachableAndReturnError(nil) {
                return true
            }
        }
        
        return false
    }
    
    
    func readJSONFile(filename: String) -> NSData? {
        
        NSLog("\(groupUrl)")
        
        let enumerator: NSDirectoryEnumerator? = fileManager.enumeratorAtURL(groupUrl, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions(), errorHandler: nil)
        
        while let element = enumerator?.nextObject() as? String {
            NSLog(element)
        }
        
        
        if let path = NSURL(string: filename, relativeToURL: groupUrl) {
        
            return NSData(contentsOfURL: path)
        }
        
        return nil
    }
    
    
    func writeJSONFile(filename: String, fileContents: String) -> Bool {
        
        if let path = NSURL(string: filename, relativeToURL: groupUrl) {
        
            do {
                try fileContents.writeToURL(path, atomically: false, encoding: NSUTF8StringEncoding)
                return true
            }
            catch {    }
        }
    
        return false
    }
    
    
    func getSharedDirectoryURL() -> NSURL {
        return groupUrl
    }
    
    
}