//
//  IResult.swift
//  ShibaInu
//
//  Created by 秋雨寒 on 2022/12/15.
//

import Foundation

public protocol IResult {
    
    var success: String? { get }
    var failure: String? { get }
}
