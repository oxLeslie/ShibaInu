//
//  Inu+Cmd.swift
//  ShibaInu
//
//  Created by zQiu on 2022/4/8.
//

import Foundation

public extension Inu where T == String {
    
    private var LANG: String {
        "export LANG=en_US.UTF-8\n"
    }
    
    /// 命令行模式
    var cmd: ICommander {
        cmd(nil)
    }
    
    /// 命令行模式 <workSpace: 工作目录>
    func cmd(_ workSpace: String?) -> ICommander {
        Command(
            path: "/bin/bash",
            args: ["-c", LANG + arg],
            workSpace: workSpace
        )
    }
}
