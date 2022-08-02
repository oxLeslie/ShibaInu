//
//  Search.swift
//  ShibaInu
//
//  Created by 秋雨寒 on 2022/8/2.
//

import Foundation

public struct Search {
    
    /// 文件搜索
    public static var engine: ISearch {
        FileSearch()
    }
}
