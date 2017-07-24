//
//  Extensions.swift
//  Pods
//
//  Created by Joshua Park on 16/12/2016.
//  Copyright © 2016 Edge. All rights reserved.
//

import Foundation

internal func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

internal func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

public extension Data {
    
    public static func json(_ object: Any) throws -> Data? {
        return try JSONSerialization.data(withJSONObject: object)
        
    }
    
}

public extension String {
    
    public init?(jsonObject: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: jsonObject)
        self.init(data: data, encoding: .utf8)
    }
    
    public func jsonDic() throws -> [String: Any]? {
        guard let data = data(using: .utf8) else { return nil }
        return try JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
    
}

public extension Dictionary {
    
    public init?(data: Data) throws {
        guard let dic = try JSONSerialization.jsonObject(with: data) as? Dictionary else { return nil }
        
        self.init(minimumCapacity: dic.count)
        for (k, v) in dic { updateValue(v, forKey: k) }
    }
    
    public func bool(_ key: Key) -> Bool? {
        return self[key] as? Bool
    }
    
    public func int(_ key: Key) -> Int? {
        return self[key] as? Int
    }
    
    public func double(_ key: Key) -> Double? {
        return self[key] as? Double
    }
    
    public func str(_ key: Key) -> String? {
        return self[key] as? String
    }
    
    public func nilStr(_ key: Key) -> String? {
        guard let str = self[key] as? String else { return nil }
        return str.characters.count > 0 ? str : nil
    }
    
    public func dic(_ key: Key) -> [String: Any]? {
        return self[key] as? [String: Any]
    }
    
    public func arr(_ key: Key) -> [Any]? {
        return self[key] as? [Any]
    }
    
    public func dicArr(_ key: Key) -> [[String: Any]]? {
        return self[key] as? [[String: Any]]
    }
    
    public func arrArr(_ key: Key) -> [[Any]]? {
        return self[key] as? [[Any]]
    }
    
}

public extension ExpressibleByArrayLiteral where Element == [String: Any] {
    
    public func element<T>(matching kvPair: (key: String, value: T)) -> Element? where T: Equatable {
        for dic in self as! [[String: Any]] {
            if dic[kvPair.key] as? T == kvPair.value { return dic }
        }
        return nil
    }
    
    public func element(withKey key: String) -> Element? {
        for dic in self as! [[String: Any]] {
            if dic[key] != nil { return dic }
        }
        return nil
    }
    
    public func element<T>(withValue value: T) -> Element? where T: Equatable {
        for dic in self as! [[String: Any]] {
            for (_, v) in dic {
                if v as? T == value { return dic }
            }
        }
        return nil
    }
    
}

public extension ExpressibleByArrayLiteral where Element == [Any] {
    
    public func element<T>(containing subElement: T) -> [Any]? where T: Equatable {
        for arr in (self as! [[Any]]) {
            for e in arr {
                if e as? T == subElement { return arr }
            }
        }
        return nil
    }
    
}


