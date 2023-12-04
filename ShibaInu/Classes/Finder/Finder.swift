//
//  Finder.swift
//  ShibaInu
//
//  Created by zQiu on 2023/12/4.
//

import Foundation

class Finder: IFinder {
    
    var directory: String?
    
    private var _isRecursive: Bool = false
    
    private var _result: [String] = []
    
    func result() -> [String] {
        _result
    }
    
    func sorted() -> Self {
        _result.sort { lhs, rhs in
            lhs.caseInsensitiveCompare(rhs) == .orderedDescending
        }
        return self
    }
    
    func recursive(_ isRecursive: Bool) -> Self {
        _isRecursive = isRecursive
        return self
    }
    
    func query(name: String) -> Self {
        let str = name.lowercased()
        _result = enumerator()?.compactMap({
            if let url = $0 as? URL,
               url.lastPathComponent.lowercased() == str
            {
                return url.path
            } else {
                return nil
            }
        }) ?? []
        return self
    }
    
    func query(extension: String) -> Self {
        let str = `extension`
            .trimmingCharacters(in: CharacterSet(charactersIn: "."))
            .lowercased()
        _result = enumerator()?.compactMap({ url in
            if let url = url as? URL,
               url.pathExtension.lowercased() == str
            {
                return url.path
            } else {
                return nil
            }
        }) ?? []
        return self
    }
    
    private func enumerator() ->FileManager.DirectoryEnumerator? {
        var url = URL(fileURLWithPath: "/")
        if let directory = directory {
            url = URL(fileURLWithPath: (directory as NSString).expandingTildeInPath)
        }
        var options: FileManager.DirectoryEnumerationOptions = [
            .skipsHiddenFiles
        ]
        if !_isRecursive {
            options.formUnion(.skipsSubdirectoryDescendants)
        }
        return FileManager.default.enumerator(
            at: url,
            includingPropertiesForKeys: nil,
            options: options,
            errorHandler: nil)
    }
}
