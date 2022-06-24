//
//  CResult.swift
//  ShibaInu
//
//  Created by zQiu on 2022/4/8.
//

import Foundation

struct CResult: IResult {
    
    let success: String?
    let failure: String?
    
    init(
        success: String? = nil,
        failure: String? = nil
    ) {
        self.success = success
        self.failure = failure
    }
}
