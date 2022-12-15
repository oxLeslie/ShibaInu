//
//  main.swift
//  ShibaInu-CLT
//
//  Created by 秋雨寒 on 2022/12/15.
//

import Foundation
import ShibaInu

print("Hello, World!")

var greeting = "Hello, playground"

let xxx = try greeting.inu.matching("lo")
print(xxx)

let rrr = InuSearch.in("/Users/zqiu/Desktop/SymbolSama.File").query(extension: ".icns").result()
print(rrr)

