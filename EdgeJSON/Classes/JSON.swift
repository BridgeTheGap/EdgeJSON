//
//  JSON.swift
//  Pods
//
//  Created by Joshua Park on 15/12/2016.
//  Copyright © 2016 Edge. All rights reserved.
//

import Foundation

//: The `JSON` structure is a light-weight wrapper / set of convenience methods,
//    designed to make it easy for people to use JSON objects.
//: All error propagation will be subdued, and optional values will be returned,
//    so as to avoid `do-catch` and `try`s in your code.

public struct JSON {

    // MARK: - JSON encoding
    
    static func data(from object: Any) -> Data? {
        return try? JSONSerialization.data(withJSONObject: object)
    }
    
    static func encodedString(from object: Any, allowEmpty: Bool = true) -> String? {
        guard let data = JSON.data(from: object) else { return nil }
        let str = String(data: data, encoding: .utf8)
        return allowEmpty || str?.isEmpty == false ? str : nil
    }
    
    // MARK: - Decoding
    
    static func dic(from string: String) -> [String: Any]? {
        return (try? string.jsonDic()) ?? nil
    }
    
    static func dic(from data: Data) -> [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
    }
    
}

func sort<T: Comparable>(array: [[String: T]], byKey key: String, ascending: Bool) -> [[String: T]] {
    return ascending ? array.sorted { return $0[key] < $1[key] } : array.sorted { return $0[key] > $1[key] }
}

func sortInPlace<T: Comparable>(array: inout [[String: T]], byKey key: String, ascending: Bool) {
    if ascending { array.sort { $0[key] < $1[key] } }
    else         { array.sort { $0[key] > $1[key] } }
}

//public func ==(lhs: [String: Any], rhs: [String: Any] ) -> Bool {
//    return NSDictionary(dictionary: lhs).isEqual(to: rhs)
//}
//
//public extension ExpressibleByArrayLiteral where Element == [String: Any] {
//    public func get<T: Equatable>(_ key: String, value: T) -> [String: Any]? {
//        for dic in self as! [[String: Any]] {
//            if let v = dic[key] , v is T && v as! T == value {
//                return dic
//            }
//        }
//        return nil
//    }
//
//    public func getWithIndex<T: Equatable>(_ key: String, value: T) -> (index: Int?, value: [String: Any]?) {
//        for (idx, dic) in (self as! [[String: Any]]).enumerated() {
//            if let v = dic[key] , v is T && v as! T == value {
//                return (idx, dic)
//            }
//        }
//        return (nil, nil)
//    }
//
//    public func getAll(_ key: String) -> [Any]? {
//        let arraySelf = self as! [[String: Any]]
//        let result = arraySelf.reduce([Any]()) {
//            if let value = $0.1[key] { return $0.0 + [value] }
//            else { return $0.0 }
//        }
//        return result.count > 0 ? result : nil
//    }
//}
//
//public extension ExpressibleByArrayLiteral where Element == [Any] {
//    public func get<T: Equatable>(_ value: T) -> [Any]? {
//        for array in self as! [[Any]] {
//            for element in array {
//                if let e = element as? T , e == value {
//                    return array
//                }
//            }
//        }
//        return nil
//    }
//}

