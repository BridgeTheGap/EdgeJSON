//
//  Array+JSON.swift
//  Pods
//
//  Created by Joshua Park on 16/12/2016.
//  Copyright © 2016 Edge. All rights reserved.
//

import Foundation

public extension Array where Element == [String: Any] {
    
    public func dic<T>(withKey key: String, value: T) -> Element? where T: Equatable {
        for dic in self {
            if dic[key] as? T == value { return dic }
        }
        return nil
    }
    
    public func dic(withKey key: String) -> Element? {
        for dic in self {
            if dic[key] != nil { return dic }
        }
        return nil
    }
    
    public func dic<T>(withValue value: T) -> Element? where T: Equatable {
        for dic in self {
            for (_, v) in dic {
                if v as? T == value { return dic }
            }
        }
        return nil
    }
    
}

public extension Array where Element == [Any] {
    
    public func element<T>(containing subElement: T) -> [Any]? where T: Equatable {
        for arr in self {
            for e in arr {
                if e as? T == subElement { return arr }
            }
        }
        return nil
    }
    
}


