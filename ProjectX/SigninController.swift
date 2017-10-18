//
//  SigninController.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/15.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import UIKit

class SigninController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}

protocol StoryLoadable : class {
    
}

extension StoryLoadable where Self : UIViewController {
    static func instantIntializeController(storyBoardName: String? = nil) -> Self! {
        
        guard let storyboard = storyBoardName else {
            let name = NSStringFromClass(self.self)
            // exclude module name
            let names = name.characters.split(separator: ".")
            let seq = names.last!.map({ $0 })
            let readName = String.init(seq)
            return UIStoryboard.init(name: readName, bundle: nil).instantiateViewController(withIdentifier: name) as! Self
        }
        let name = NSStringFromClass(self.self)
        // exclude module name
        let names = name.characters.split(separator: ".")
        let seq = names.last!.map({ $0 })
        let readName = String.init(seq)
        return UIStoryboard.init(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: readName) as! Self
        
    }
}

extension UIView {
    
    @IBInspectable var mborderColor : UIColor {
        get {
            return self.layer.borderColor != nil ? UIColor(cgColor: self.layer.borderColor!) : UIColor.clear
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var mborderWidth : CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var mborderRadius : CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    
}


extension UIButton {
    @IBInspectable var selectedBackgrondColor : UIColor {
        get {
            return self.backgroundColor ?? .clear
        }
        set {
            self.setBackgroundImage(newValue.image(), for: .selected)
        }
    }
    
    @IBInspectable var normalBackgrondColor : UIColor {
        get {
            return self.backgroundColor ?? .clear
        }
        set {
            self.setBackgroundImage(newValue.image(), for: .normal)
        }
    }
    
    @IBInspectable var highlightedBackgrondColor : UIColor {
        get {
            return self.backgroundColor ?? .clear
        }
        set {
            self.setBackgroundImage(newValue.image(), for: .highlighted)
        }
    }
    
    @IBInspectable var disabledBackgrondColor : UIColor {
        get {
            return self.backgroundColor ?? .clear
        }
        set {
            self.setBackgroundImage(newValue.image(), for: .disabled)
        }
    }
}

extension UIColor {
    func image() -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width:1, height:1));
        let context = UIGraphicsGetCurrentContext();
        context?.setFillColor(self.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return image
    }
}

