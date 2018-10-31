//
//  ImportExport.swift
//  uds_avl_tree
//
//  Created by Juraj Macák on 10/29/18.
//  Copyright © 2018 Juraj Macák. All rights reserved.
//

import Foundation

final class ImportExport {
    
    fileprivate let fileName = "datasource"
    fileprivate var path: String!
    let documentsPath     = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    fileprivate var _fileManager = FileManager.default
    fileprivate var _fileHandle:   FileHandle?
    
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
    
    func write(line: String) {
        let output = line
        _fileHandle?.write(output.data(using: String.Encoding.utf8)!)
    }
    
}
