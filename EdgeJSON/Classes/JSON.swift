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
    
    public enum TypeError: Error {
        case stringConversionError
        case dataConversionError
        case initializationError
        case invalidType(Any.Type)
        case invalidKey(String)
        case invalidValueType(key: String, type: Any.Type)
    }
    
    public enum ElementType {
        case string
        case int
        case double
        case bool
        case array
        case dictionary
    }
    
    public static var errorHandler: JSONErrorHandler? = nil
    
    // MARK: - JSON encoding
    
    public static func data(from object: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])
        } catch {
            errorHandler?.handle(error: error)
            return nil
        }
    }
    
    public static func string(from object: Any) -> String? {
        guard let data = JSON.data(from: object) else { return nil }
        let str = String(data: data, encoding: .utf8)
        return str?.isEmpty == false ? str : nil
    }
    
    // MARK: - Decoding
    
    private static func dictionary(from data: Data, options: JSONSerialization.ReadingOptions = []) throws -> [String: Any]? {
        guard let json = try JSONSerialization.jsonObject(with: data,
                                                          options: options) as? [String: Any] else
        {
            throw TypeError.invalidType([String: Any].self)
        }
        
        return json
    }
    
    public static func dic(from string: String, options: JSONSerialization.ReadingOptions = []) -> [String: Any]? {
        do {
            guard let data = string.data(using: .utf8) else {
                throw TypeError.dataConversionError
            }
            
            return try dictionary(from: data, options: options)
        } catch {
            errorHandler?.handle(error: error)
            
            return nil
        }
    }
    
    public static func dic(from data: Data, options: JSONSerialization.ReadingOptions = []) -> [String: Any]? {
        do {
            return try dictionary(from: data, options: options)
        } catch {
            errorHandler?.handle(error: error)
            return nil
        }
    }
    
    // MARK: - Data checker
    
    public static func checkJSON(_ json: [String: Any], with dataChecker: [String: ElementType]) -> Bool {
        var errors = [TypeError]()
        
        for (key, type) in dataChecker {
            guard let value = json[key] else {
                errors.append(.invalidKey(key))
                continue
            }
            
            switch type {
            case .array:
                guard value is [Any] else {
                    errors.append(.invalidValueType(key: key, type: [Any].self))
                    continue
                }
            case .bool:
                guard value is Bool else {
                    errors.append(.invalidValueType(key: key, type: Bool.self))
                    continue
                }
            case .dictionary:
                guard value is [String: Any] else {
                    errors.append(.invalidValueType(key: key, type: [String: Any].self))
                    continue
                }
            case .double:
                guard value is Double else {
                    errors.append(.invalidValueType(key: key, type: Double.self))
                    continue
                }
            case .int:
                guard value is Int else {
                    errors.append(.invalidValueType(key: key, type: Int.self))
                    continue
                }
            case .string:
                guard value is String else {
                    errors.append(.invalidValueType(key: key, type: String.self))
                    continue
                }
            }
        }
        
        if errors.isEmpty {
            return true
        } else {
            for error in errors {
                errorHandler?.handle(error: error)
            }
            
            return false
        }
        
    }
    
    // MARK: - Interface
    
    private var item: [String: Any]
    
    public init?(_ dictionary: [String: Any], _ dataChecker: [String: ElementType]) {
        guard JSON.checkJSON(dictionary, with: dataChecker) else { return nil }
        item = dictionary
    }
    
    public func bool(_ key: String) -> Bool {
        return item[key] as! Bool
    }
    
    public func int(_ key: String) -> Int {
        return item[key] as! Int
    }
    
    public func double(_ key: String) -> Double {
        return item[key] as! Double
    }
    
    public func str(_ key: String) -> String {
        return item[key] as! String
    }
    
    public func dic(_ key: String) -> [String: Any] {
        return item[key] as! [String: Any]
    }
    
    public func arr(_ key: String) -> [Any] {
        return item[key] as! [Any]
    }
    
}
