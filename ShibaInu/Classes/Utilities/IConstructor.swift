//
//  IConstructor.swift
//  ShibaInu
//
//  Created by zQiu on 2022/4/7.
//

import Foundation

protocol IConstructor {}

extension NSObject: IConstructor {}

extension IConstructor where Self: NSObject {
    
    init(closure: (Self) -> Void) {
        self.init()
        closure(self)
    }
}
