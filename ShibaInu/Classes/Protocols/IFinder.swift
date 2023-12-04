//
//  IFinder.swift
//  ShibaInu
//
//  Created by zQiu on 2023/12/4.
//

import Foundation

public protocol IFinder {
    
    /// 搜索结果
    func result() -> [String]
    
    /// 结果排序
    func sorted() -> Self
    
    /// 递归搜索
    func recursive(_ isRecursive: Bool) -> Self
    
    /// 文件名称
    func query(name: String) -> Self
    
    /// 文件类型
    func query(extension: String) -> Self
}
