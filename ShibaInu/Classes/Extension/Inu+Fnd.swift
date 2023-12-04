//
//  Inu+Fnd.swift
//  ShibaInu
//
//  Created by zQiu on 2023/12/4.
//

import Foundation

public extension Inu where T == String {
    
    var fnd: IFinder {
        let object = Finder()
        object.directory = arg
        return object
    }
}
