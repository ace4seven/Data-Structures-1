//
//  ImportExport.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/29/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

enum MigrationHeaderType {
    case persons(count: Int)
    case regions(count: Int)
    case ownedLists(count: Int)
    case shares(count: Int)
    case properties(count: Int)
    
    var header: String {
        switch self {
        case .regions(let count):
            return "REGIONS\(C.separator)\(count)\(C.newLine)"
        case .persons(let count):
            return "PERSONS\(C.separator)\(count)\(C.newLine)"
        case .ownedLists(let count):
            return "OWNEDLISTS\(C.separator)\(count)\(C.newLine)"
        case .shares(let count):
            return "SHARES\(C.separator)\(count)\(C.newLine)"
        case .properties(let count):
            return "PROPERTIES\(C.separator)\(count)\(C.newLine)"
        }
    }
    
}

final class ImportExport {
    
    fileprivate let fileName = "datasource"
    fileprivate var path: String!
    
    fileprivate var _fileManager = FileManager.default
    fileprivate var _fileHandle:   FileHandle?
    fileprivate var _scanner: Scanner?
    
    init() {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv") else {
            return
        }
        self.path = path
    }
    
    var fileManager: FileManager {
        get {
            return self._fileManager
        }
    }
    
    var fileHandler: FileHandle {
        get {
            return self._fileHandle!
        }
    }
    
    var scanner: Scanner {
        get {
            return self._scanner!
        }
    }
    
}

// MARK: - Publics

extension ImportExport {
    
    func prepareForExport() {
        print(path)
        do {
            try _fileManager.removeItem(atPath: path)
        } catch let error {
            debugPrint("\(error)")
        }
        
        _fileManager.createFile(atPath: path, contents: nil, attributes: nil)
        _fileHandle = FileHandle(forUpdatingAtPath: path)
        _fileHandle?.seekToEndOfFile()
    }
    
    func prepareForImport() {
        let csvFile = try! String(contentsOfFile: self.path, encoding: String.Encoding.utf8)
        self._scanner = Scanner(string: csvFile)
    }
    
    func write(line: String) {
        let output = line
        _fileHandle?.write(output.data(using: String.Encoding.utf8)!)
    }
    
    func write(headerType: MigrationHeaderType) {
        let output = headerType.header
        _fileHandle?.write(output.data(using: String.Encoding.utf8)!)
    }
    
    func readCSV(newLine: @escaping ([String]?) -> ()) {
        var line: NSString?
        while scanner.scanUpTo("\n", into: &line) {
            let components = line?.components(separatedBy: C.separator)
            newLine(components)
        }
    }
    
}
