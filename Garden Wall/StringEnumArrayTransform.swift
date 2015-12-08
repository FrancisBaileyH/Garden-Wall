//
//  EnumArrayTransform.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-07.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//

import Foundation
import ObjectMapper



public class StringEnumArrayTransform<T: RawRepresentable>: TransformType {
    
    
    public typealias Object = [T]
    public typealias JSON = String
    
    
    
    public func transformFromJSON(value: AnyObject?) -> [T]? {
        
        if let implodedString = value as? String {
            
            var enumArray: [T] = [T]()
            
            for stringValue in implodedString.componentsSeparatedByString(",") {

                if let rawValue = stringValue as? T.RawValue {
                    enumArray.append(T(rawValue: rawValue)!)
                }
            }
            
            return enumArray
        }
        
        return nil
    }
    
    
    public func transformToJSON(value: [T]?) -> String? {
        
        var jsonString: String = ""
        
        if let enumArray = value {
         
            for enumType in enumArray {
                
                if let rawStringValue = enumType.rawValue as? String {
                    jsonString += rawStringValue + ","
                }
            }
            
            if jsonString.characters.last == "," {
                jsonString.removeAtIndex(jsonString.endIndex.predecessor())
            }
            
            return jsonString
        }
        
        return nil
    }
    
}