//
//  Command.swift
//  ShibaInu
//
//  Created by zQiu on 2022/4/7.
//

import Foundation

struct Command: ICommander {
    
    let path: String?
    
    let args: [String]?
    
    let workSpace: String?
    
    var envs: [String: String] {
        var environment = ProcessInfo.processInfo.environment
        environment["PATH"] = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        return environment
    }
    
    func sync() -> IResult {
        let _workSpace = getcwd(nil, 0)
        chdir((workSpace as NSString?)?.fileSystemRepresentation)
        defer { chdir(_workSpace) }
        
        let output = Pipe()
        let error  = Pipe()
        
        let process = Process()
        process.launchPath     = self.path
        process.arguments      = self.args
        process.environment    = self.envs
        process.standardOutput = output
        process.standardError  = error
        
        do {
            try OCTry {
                process.launch()
                process.waitUntilExit()
            }
        } catch {
            return CmdResult(failure: error.localizedDescription)
        }
        
        if process.terminationStatus == 0 {
            let d = output.fileHandleForReading.readDataToEndOfFile()
            return CmdResult(success: String(data: d, encoding: .utf8))
        } else {
            let d = error.fileHandleForReading.readDataToEndOfFile()
            return CmdResult(failure: String(data: d, encoding: .utf8))
        }
    }
    
    func async(result: @escaping (String?) -> Void, termination: @escaping (Int32) -> Void) {
        DispatchQueue.global().async {
            let _workSpace = getcwd(nil, 0)
            chdir((self.workSpace as NSString?)?.fileSystemRepresentation)
            
            let output = Pipe()
            output.fileHandleForReading.waitForDataInBackgroundAndNotify()
            
            let process = Process()
            process.launchPath         = self.path
            process.arguments          = self.args
            process.environment        = self.envs
            process.standardOutput     = output
            process.terminationHandler = { _p in
                chdir(_workSpace)
                DispatchQueue.main.async {
                    termination(_p.terminationStatus)
                }
            }
            
            NotificationCenter.default.addObserver(
                forName: .NSFileHandleDataAvailable,
                object: output.fileHandleForReading, queue: nil)
            {
                guard let handle = $0.object as? FileHandle,
                      !handle.availableData.isEmpty else
                {
                    output.fileHandleForReading.closeFile()
                    return
                }
                let res = String(data: handle.availableData, encoding: .utf8)
                DispatchQueue.main.async { result(res) }
                handle.waitForDataInBackgroundAndNotify()
            }
            
            do {
                try OCTry {
                    process.launch()
                    process.waitUntilExit()
                }
            } catch {
                DispatchQueue.main.async { result(error.localizedDescription) }
                output.fileHandleForReading.closeFile()
            }
        }
    }
}
