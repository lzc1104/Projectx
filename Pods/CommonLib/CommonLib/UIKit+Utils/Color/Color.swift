//
//  Color.swift
//  PokerCycle
//
//  Created by lzc1104 on 2016/12/21.
//  Copyright © 2016年 Dewinsports. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    
    
    convenience init(hex : Int) {
        self.init(hex: hex, alpha: 1)
    }
    
    convenience init(hex : Int , alpha : CGFloat) {
        let r = CGFloat((hex >> 16) & 0xff) / 255.0
        let g = CGFloat(hex >> 8 & 0xff) / 255.0
        let b = CGFloat(hex & 0xff) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    
    static var random : UIColor {
        let r = CGFloat(arc4random_uniform(255)) / 255.0;
        let g = CGFloat(arc4random_uniform(255)) / 255.0;
        let b = CGFloat(arc4random_uniform(255)) / 255.0;
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    /// cccccccc
    func dashLine(space : CGFloat , dashLength : CGFloat) -> UIColor {
        let size = CGSize(width: dashLength + space , height: dashLength + space)
        UIGraphicsBeginImageContext(size)
        let contenxt = UIGraphicsGetCurrentContext()
        
        let spaceRect = CGRect(x: dashLength, y: 0, width: dashLength + space, height: dashLength + space)
        contenxt?.setFillColor(UIColor.white.cgColor)
        contenxt?.fill(spaceRect)
        
        let dashRect = CGRect(x: 0, y: 0, width: dashLength, height: dashLength)
        contenxt?.setFillColor(self.cgColor)
        contenxt?.fill(dashRect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIColor.clear }
        
        UIGraphicsEndImageContext()
        let color = UIColor(patternImage: image)
        return color
    }
    
    func Image() -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width:1, height:1));
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(self.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return image
    }
}
