//
//  Inu+Pattern.swift
//  ShibaInu
//
//  Created by zQiu on 2022/4/8.
//

import Foundation

public extension Inu where T == String {
    
    func matching(
        _ pattern: String,
        options: NSRegularExpression.Options = []) throws -> [String]
    {
        try multimatching(
            pattern,
            options: options)
        .flatMap {
            $0
        }
    }
    
    func multimatching(
        _ pattern: String,
        options: NSRegularExpression.Options = []) throws -> [[String]]
    {
        try expression(
            pattern,
            options: options)
        .compactMap { o in
            let c = o.numberOfRanges
            let s = c == 1 ? 0 : 1
            let e = max(s, c)
            let r: [String] = (s..<e).compactMap { i in
                guard let range = Range<String.Index>(
                    o.range(at: i),
                    in: arg) else {
                    return nil
                }
                return String(arg[range])
            }
            return r
        }
    }
    
    func expression(
        _ pattern: String,
        options: NSRegularExpression.Options = []) throws -> [NSTextCheckingResult]
    {
        try NSRegularExpression(
            pattern: pattern,
            options: options)
        .matches(
            in: arg,
            options: [],
            range: NSRange(arg.startIndex..., in: arg))
    }
}
