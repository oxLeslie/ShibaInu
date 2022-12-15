//
//  ISearch.swift
//  ShibaInu
//
//  Created by 秋雨寒 on 2022/12/15.
//

import Foundation

public protocol ISearch {
    
    /// 搜索结果
    func result() -> [String]
    
    /// 结果排序
    func sorted() -> Self
    
    /// 递归搜索
    func recursive(_ isRecursive: Bool) -> Self
    
    /// 目标目录
    func `in`(_ directory: String) -> Self
    
    /// 文件名称
    func query(name: String) -> Self
    
    /// 文件类型
    func query(extension: String) -> Self
}
