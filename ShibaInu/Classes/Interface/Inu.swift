//
//  Inu.swift
//  ShibaInu
//
//  Created by zQiu on 2022/4/8.
//

import Foundation

public struct Inu<T> {
    
    let arg: T
}

// MARK: - Extension

public extension Float {
    
    var inu: Inu<Self> {
        Inu(arg: self)
    }
}

public extension Double {
    
    var inu: Inu<Self> {
        Inu(arg: self)
    }
}

public extension String {
    
    var inu: Inu<Self> {
        Inu(arg: self)
    }
}
