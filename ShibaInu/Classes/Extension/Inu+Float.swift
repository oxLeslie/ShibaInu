//
//  Inu+Float.swift
//  ShibaInu
//
//  Created by zQiu on 2022/4/16.
//

import Foundation

public extension Inu where T == Float {
    
    /// 排除小数点`无效 0`
    var pretty: String {
        arg.truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", arg)
        : String(arg)
    }
    
    /// 排除小数点`无效 0` <默认保留两位小数>
    func pretty(_ digit: Int = 2) -> String {
        arg.truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", arg)
        : String(format: "%.\(digit)f", arg)
    }
}

public extension Inu where T == Double {
    
    /// 排除小数点`无效 0`
    var pretty: String {
        arg.truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", arg)
        : String(arg)
    }
    
    /// 排除小数点`无效 0` <默认保留两位小数>
    func pretty(_ digit: Int = 2) -> String {
        arg.truncatingRemainder(dividingBy: 1) == 0
        ? String(format: "%.0f", arg)
        : String(format: "%.\(digit)f", arg)
    }
}
