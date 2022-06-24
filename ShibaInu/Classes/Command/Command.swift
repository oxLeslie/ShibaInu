//
//  Command.swift
//  ShibaInu
//
//  Created by zQiu on 2022/4/7.
//

import Foundation

struct Command: ICommander {
    
    var path: String?
    var args: [String]?
    var workSpace: String?
    
    private var envs: [String: String] {
        var environment = ProcessInfo.processInfo.environment
        environment["PATH"] = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        return environment
    }
}

extension Command {
    
    func sync() -> IResult {
        let _workSpace = getcwd(nil, 0)
        chdir((workSpace as NSString?)?.fileSystemRepresentation)
        defer { chdir(_workSpace) }
        
        let output = Pipe()
        let error  = Pipe()
        
        let p = Process {
            $0.launchPath  = path
            $0.arguments   = args
            $0.environment = envs
            
            $0.standardOutput = output
            $0.standardError  = error
        }
        
        do {
            try OCTry {
                p.launch()
                p.waitUntilExit()
            }
        } catch {
            return CResult(failure: error.localizedDescription)
        }
        
        if p.terminationStatus == 0 {
            let d = output.fileHandleForReading.readDataToEndOfFile()
            return CResult(success: String(data: d, encoding: .utf8))
        } else {
            let d = error.fileHandleForReading.readDataToEndOfFile()
            return CResult(failure: String(data: d, encoding: .utf8))
        }
    }
    
    func async(result: @escaping (String?) -> Void, termination: @escaping (Int32) -> Void) {
        DispatchQueue.global().async {
            let _workSpace = getcwd(nil, 0)
            chdir((self.workSpace as NSString?)?.fileSystemRepresentation)
            
            let output = Pipe {
                $0.fileHandleForReading.waitForDataInBackgroundAndNotify()
            }
            
            let process = Process {
                $0.launchPath  = self.path
                $0.arguments   = self.args
                $0.environment = self.envs
                $0.standardOutput = output
                
                $0.terminationHandler = { _p in
                    chdir(_workSpace)
                    DispatchQueue.main.async {
                        termination(_p.terminationStatus)
                    }
                }
            }
            
            NotificationCenter.default.addObserver(forName: .NSFileHandleDataAvailable, object: output.fileHandleForReading, queue: nil) {
                guard let handle = $0.object as? FileHandle, !handle.availableData.isEmpty else {
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
