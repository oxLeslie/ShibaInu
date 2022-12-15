//
//  main.swift
//  Example-CLT
//
//  Created by zQiu on 2022/4/18.
//

import Foundation
import ShibaInu

print("Hello, World!")

var greeting = "Hello, playground"

let xxx = try greeting.inu.matching("lo")
print(xxx)

let rrr = InuSearch.in("/Users/zqiu/Desktop/SymbolSama.File").query(extension: ".icns").result()
print(rrr)
