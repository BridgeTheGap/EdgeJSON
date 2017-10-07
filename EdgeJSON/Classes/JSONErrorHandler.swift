//
//  JSONErrorHandler.swift
//  Pods
//
//  Created by Joshua Park on 29/07/2017.
//  Copyright © 2017 Edge. All rights reserved.
//

import Foundation

public protocol JSONErrorHandler {
    
    func handle(error: Error)
    
}
