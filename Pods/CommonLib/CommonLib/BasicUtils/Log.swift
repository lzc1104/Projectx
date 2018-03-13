//
//  Log.swift
//  MatchDay
//
//  Created by Garen on 16/9/29.
//  Copyright © 2016年 cgc. All rights reserved.
//

import Foundation

#if DEBUG
    
    public func DebugLog (_ items: Any?...,filePath:String = #file, line:Int = #line, function:String = #function) {
        
    var path = filePath.components(separatedBy: "/")
    if let fileName = path.popLast() {
        let str = "\n\(Date()) [" + fileName + " < \(function) > in Line:\(line)]"
        print(str,terminator:":➡️")
        for item in items {
            if let _ = item {
                print(item!)
            }
            
        }
    } else {
        print("File path error😱!")
    }
        
}

#else
    
public func DebugLog(_ items: Any...) {}
    
#endif

