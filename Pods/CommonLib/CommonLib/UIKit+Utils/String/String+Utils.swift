//
//  String+Utils.swift
//  PokerQuan
//
//  Created by lzc1104 on 2017/1/13.
//  Copyright © 2017年 Dewinsports. All rights reserved.
//

import Foundation


extension String {
    var uint64Valuee : Int64? {
        if self.isEmpty {
            return nil
        }
        let cattrs : [Character] = self.characters.reversed()
        var value : Int64 = 0
        var dotIndex = -1
        for turple in cattrs.enumerated() {
            let singleC = turple.element.description
            if singleC == "." {
                if dotIndex != -1 {
                    //两个dot
                    return nil
                }
                dotIndex = cattrs.index(of: ".")! + 1
                value = 0
                continue
                
            }
            let invalue = (singleC as NSString).integerValue
            
            if invalue == 0 {
                if singleC == "0" {
                    continue
                } else {
                    //非法字符
                    return nil
                }
                
            } else {
                
                var loopTimes = turple.offset
                if dotIndex != -1 {
                    loopTimes -= dotIndex
                }
                var times : Int64 = 1
                for _ in 0..<loopTimes {
                    times *= 10
                }
                
                let addValue = Int64(invalue) * times
                value += addValue
                
                
            }
        }
        
        return value
    }
}

extension String {

    mutating func replacingCharacters(in range: CountableRange<Int>, with replacement: String) -> String {
        if self.isEmpty { return self }
        
        let l = range.lowerBound
        let h = range.upperBound
        
        if self.characters.count - 1 > h {
            return self
        }
        
        if l < 0 {
            return self
        }
        
        if l > h { return self }
        if l == h {
            return self
        }
        let r = Range<String.Index>.init(uncheckedBounds: (lower: self.index(self.startIndex, offsetBy: l),
                                                           upper: self.index(self.startIndex, offsetBy: h)))
        
        return self.replacingCharacters(in: r, with: replacement)
    }
}

extension String {
    func isChineseAndEnglish() -> Bool {
        let regex = try? NSRegularExpression(pattern: "[^\u{4e00}-\u{9fa5}a-zA-Z0-9]+", options: .caseInsensitive)
        let matches = regex?.matches(in: self, options: .reportProgress, range: NSMakeRange(0, self.characters.count)) ?? []
        return matches.isEmpty
        
    }
    
    func chineseCount() -> Int {
        if self.isEmpty { return 0 }
        let regex = try? NSRegularExpression(pattern: "[\u{4e00}-\u{9fa5}]{1}", options: .caseInsensitive)
        let matches = regex?.matches(in: self, options: .reportProgress, range: NSMakeRange(0, self.characters.count)) ?? []
        return matches.count
    }
    
    func composeCount() -> Int {
        if self.isEmpty { return 0 }
        let regex = try? NSRegularExpression(pattern: "[\u{4e00}-\u{9fa5}]{1}", options: .caseInsensitive)
        let matches = regex?.matches(in: self, options: .reportProgress, range: NSMakeRange(0, self.characters.count)) ?? []
        let cnCount = matches.count
        let nonCNcount = self.characters.count - cnCount
        return cnCount * 2 + nonCNcount
        
        
    }
    
}
