//
//  ViewController.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/15.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class CustomNavigatioController: UINavigationController {
    
}


class CustomTabBarController: UITabBarController,StoryLoadable {
    
    func configureApperaence() {
        self.view.backgroundColor = .white
        let dict1 = AttributeDict.make
            .setAttri(NSForegroundColorAttributeName)(Color.White.white3)
            .setAttri(NSFontAttributeName)(UIFont.systemFont(ofSize: 13))
            .end()
        let dict2 = AttributeDict.make
            .setAttri(NSForegroundColorAttributeName)(Color.Gold.gold5)
            .setAttri(NSFontAttributeName)(UIFont.systemFont(ofSize: 13))
            .end()
        
        UINavigationBar.appearance().barTintColor = Color.Black.navigation
        UINavigationBar.appearance().tintColor = UIColor.white
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes =
            AttributeDict.make
                .setAttri(NSForegroundColorAttributeName)(UIColor.white)
                .setAttri(NSFontAttributeName)(UIFont.boldSystemFont(ofSize: 18))
                .end()
        
        UITabBarItem.appearance().setTitleTextAttributes(dict1, for: UIControlState.normal)
        
        UITabBarItem.appearance().setTitleTextAttributes(dict2, for: UIControlState.selected)
        
        UITabBar.appearance().barTintColor = Color.Black.tab
        
        UITabBar.appearance().isTranslucent = false
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.configureApperaence()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureApperaence()
    }
    
}



    
