//
//  DebugLog.swift
//  LiveStream
//
//  Created by Lamine Ndiaye on 10/06/2017.
//
//

import Foundation

func debugLog(_ object: Any? = "", path: String = #file, function: String = #function) {
    #if DEBUG
        let fullFileName = NSString(string: path).lastPathComponent
        let fileName = NSString(string: fullFileName).deletingPathExtension
        guard let object = object else {
            return
        }
        print("\(NSDate()) : \(fileName) -> \(function) : \(object)")
    #endif
}
