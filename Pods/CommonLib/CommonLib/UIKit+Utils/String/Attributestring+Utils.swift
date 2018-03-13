//
//  Attributestring+Utils.swift
//  PokerCycle
//
//  Created by lzc1104 on 2016/12/21.
//  Copyright © 2016年 Dewinsports. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func renderImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        guard let _ = context else { return nil }
        self.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func spacing() -> NSAttributedString {
        let attch = NSTextAttachment()
        attch.image = self.renderImage()
        return NSAttributedString(attachment: attch)
    }
    
    func attachMentString() -> NSAttributedString {
        let attch = NSTextAttachment()
        attch.image = self.renderImage()
        return NSAttributedString(attachment: attch)
    }
    
}

func +(lhs : NSAttributedString , rhs : NSAttributedString) -> NSAttributedString {
    let wrap = NSMutableAttributedString()
    wrap.append(lhs)
    wrap.append(rhs)
    return wrap
}

