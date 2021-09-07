//
//  OCThrows.swift
//  ShibaInu
//
//  Created by zQiu on 2021/9/7.
//

import Foundation
import ObjC

extension NSException: Error {}

@discardableResult
func OCTry<T>(_ execute: () throws -> T) throws -> T {
    
    var _error: Error?
    var result: T!
    
    OCCatcher(
        { do { result = try execute() } catch { _error = error } },
        { _error = $0 }
    )
    
    if let _error = _error {
        throw _error
    } else {
        return result
    }
}
