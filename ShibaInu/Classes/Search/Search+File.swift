//
//  Search+File.swift
//  ShibaInu
//
//  Created by 秋雨寒 on 2022/7/29.
//

import Foundation

class FileSearch: ISearch {
    
    private var isRecursive: Bool = false
    private var directory: String?
    
    var results: [String] = []
    
    func sorted() -> Self {
        results.sort {
            $0.caseInsensitiveCompare($1) == .orderedDescending
        }
        return self
    }
    
    func recursive(_ isRecursive: Bool) -> Self {
        self.isRecursive = isRecursive
        return self
    }
    
    func `in`(_ directory: String) -> Self {
        self.directory = directory
        return self
    }
    
    func query(name: String) -> Self {
        let _name = name.lowercased()
        results = enumerator?.compactMap {
            if let url = $0 as? URL,
               url.lastPathComponent.lowercased() == _name
            {
                return url.path
            } else {
                return nil
            }
        } ?? []
        return self
    }
    
    func query(extension: String) -> Self {
        let _name = `extension`
            .trimmingCharacters(in: CharacterSet(charactersIn: "."))
            .lowercased()
        results = enumerator?.compactMap { url in
            if let url = url as? URL,
               url.pathExtension.lowercased() == _name
            {
                return url.path
            } else {
                return nil
            }
        } ?? []
        return self
    }
}

private extension FileSearch {
    
    var enumerator: FileManager.DirectoryEnumerator? {
        var url = URL(fileURLWithPath: "/")
        
        if let directory = directory {
            url = URL(fileURLWithPath: (directory as NSString).expandingTildeInPath)
        }

        var options: FileManager.DirectoryEnumerationOptions = [
            .skipsHiddenFiles
        ]
        
        if !isRecursive {
            options.formUnion(.skipsSubdirectoryDescendants)
        }

        return FileManager.default.enumerator(
            at: url,
            includingPropertiesForKeys: nil,
            options: options,
            errorHandler: nil
        )
    }
}
