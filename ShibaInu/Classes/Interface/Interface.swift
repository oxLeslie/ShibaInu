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

public protocol ISearch {
    // 搜索结果
    var results: [String] { get }
    
    // 对结果排序
    func sorted() -> Self
    
    /// 是否<递归>搜索
    func recursive(_ isRecursive: Bool) -> Self
    
    /// 在<目标目录>搜索
    func `in`(_ directory: String) -> Self
    
    /// 根据<文件名称>搜索
    func query(name: String) -> Self
    
    /// 根据<文件类型>搜索
    func query(extension: String) -> Self
}
