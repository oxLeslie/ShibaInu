//
//  ICommander.swift
//  ShibaInu
//
//  Created by 秋雨寒 on 2022/12/15.
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
