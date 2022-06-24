//
//  Interface.swift
//  ShibaInu
//
//  Created by zQiu on 2022/4/8.
//

import Foundation

public protocol ICommander {
    
    /// 同步命令行
    func sync() -> IResult
    
    /// 异步命令行
    /// - Parameters:
    ///   - result: 执行结果
    ///   - termination: 执行状态
    func async(result: @escaping (String?) -> Void, termination: @escaping (Int32) -> Void)
}

public protocol IResult {
    
    var success: String? { get }
    var failure: String? { get }
}
