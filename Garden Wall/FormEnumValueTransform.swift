//
//  SwiftFormsEnumTransform.swift
//  Garden Wall
//
//  Created by Francis Bailey on 2015-12-09.
//  Copyright © 2015 Francis Bailey. All rights reserved.
//


import Foundation



class FormEnumValueTransform<T: protocol<RawRepresentable, Hashable>, U: protocol<StringLiteralConvertible>> {
    
    
    func transformFromFormValue(value: [U]?) -> [T]? {
        
        var enumArray = [T]()
        
        if let arr = value {
            
            for item in arr {
                
                if let rawValue = item as? T.RawValue, let enumValue = T(rawValue: rawValue) {
                    enumArray.append(enumValue)
                }
            }
            
            return enumArray.count > 0 ? enumArray : nil
        }
        
        return nil
    }
    
    
    func transformToFormValue() -> [U]? {
        
        var uArray = [U]()
        
        for item in iterateEnum(T) {
            
            if let value = item.rawValue as? U {
                
                uArray.append(value)
            }
        }
        
        if uArray.count > 0 {
            return uArray
        }
        
        
        return nil
    }
    
    
    func transformToFormValue(values: [T]?) -> [U]? {
        
        var uArray = [U]()
        
        if let arr = values {
            
            for item in arr {
            
                if let uValue = item.rawValue as? U {
                    uArray.append(uValue)
                }
            
            }
            
            return uArray.count > 0 ? uArray : nil
        }
        
        return nil
    }
    
    
    func iterateEnum<T: Hashable>(_: T.Type) -> AnyGenerator<T> {
        
        var i = 0
        
        return anyGenerator {
            
            let next = withUnsafePointer(&i) { UnsafePointer<T>($0).memory }
            return next.hashValue == i++ ? next : nil
        }
    }
    
}
