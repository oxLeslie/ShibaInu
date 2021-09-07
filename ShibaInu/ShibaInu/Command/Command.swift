//
//  Command.swift
//  ShibaInu
//
//  Created by zQiu on 2021/9/7.
//

import Foundation

public struct Command {
    
    public struct Result {
        public let success: String?
        public let failure: String?
        
        public init(success: String? = nil, failure: String? = nil) {
            self.success = success
            self.failure = failure
        }
    }
    
    public static func sync(_ path: String,
                            arguments: String...,
                            workSpace cwd: String? = nil) -> Result
    {
        let outPipe = Pipe()
        let errPipe = Pipe()
        let process = Process()
        
        let pwd = getcwd(nil, 0)
        chdir((cwd as NSString?)?.fileSystemRepresentation)
        defer { chdir(pwd) }
        
        process.launchPath = path
        process.arguments = arguments
        process.environment = environment
        process.standardOutput = outPipe
        process.standardError = errPipe
        
        do {
            try OCTry { process.launch(); process.waitUntilExit() }
        } catch {
            return Result(failure: error.localizedDescription)
        }
        
        if process.terminationStatus == 0 {
            let data = outPipe.fileHandleForReading.readDataToEndOfFile()
            return Result(success: String(data: data, encoding: .utf8))
        } else {
            let data = errPipe.fileHandleForReading.readDataToEndOfFile()
            return Result(failure: String(data: data, encoding: .utf8))
        }
    }
    
    public static func async(_ path: String,
                             arguments: String...,
                             workSpace cwd: String? = nil,
                             result: @escaping (String?) -> Void,
                             termination: ((Int32) -> Void)? = nil)
    {
        DispatchQueue.global().async {
            let outPipe = Pipe()
            let process = Process()
            
            let pwd = getcwd(nil, 0)
            chdir((cwd as NSString?)?.fileSystemRepresentation)
            
            process.launchPath = path
            process.arguments = arguments
            process.environment = environment
            process.standardOutput = outPipe
            
            process.terminationHandler = { _process in
                chdir(pwd)
                DispatchQueue.main.async {
                    termination?(_process.terminationStatus)
                }
            }
            
            outPipe
                .fileHandleForReading
                .waitForDataInBackgroundAndNotify()
            
            NotificationCenter
                .default
                .addObserver(forName: .NSFileHandleDataAvailable,
                             object: outPipe.fileHandleForReading,
                             queue: nil) {
                    if let obj = $0.object as? FileHandle, !obj.availableData.isEmpty {
                        let rs = String(data: obj.availableData, encoding: .utf8)
                        DispatchQueue.main.async { result(rs) }
                        obj.waitForDataInBackgroundAndNotify()
                    } else {
                        outPipe.fileHandleForReading.closeFile()
                    }
                }
            
            do {
                try OCTry { process.launch(); process.waitUntilExit() }
            } catch {
                DispatchQueue.main.async { result(error.localizedDescription) }
                outPipe.fileHandleForReading.closeFile()
            }
        }
    }
}

public extension Command {
    
    /// BaseOn：
    /// ```
    ///     path: /bin/sh
    ///     argu: export LANG=en_US.UTF-8
    /// ```
    static func sync(argument: String, workSpace cwd: String? = nil) -> Result {
        sync("/bin/sh", arguments: "-c", LANG + argument, workSpace: cwd)
    }
    
    /// BaseOn：
    /// ```
    ///     path: /bin/sh
    ///     argu: export LANG=en_US.UTF-8
    /// ```
    static func async(argument: String,
                      workSpace cwd: String? = nil,
                      result: @escaping (String?) -> Void,
                      termination: ((Int32) -> Void)? = nil)
    {
        async("/bin/sh",
              arguments: "-c", LANG + argument,
              workSpace: cwd,
              result: result,
              termination: termination)
    }
}

private extension Command {
    
    static var LANG: String {
        "export LANG=en_US.UTF-8\n"
    }
    
    static var environment: [String: String] {
        var environment = ProcessInfo.processInfo.environment
        environment["PATH"] = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        return environment
    }
}
