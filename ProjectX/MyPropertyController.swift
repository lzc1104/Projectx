//
//  MyPropertyController.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/15.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MyPropertyController: UIViewController {

    //MARK: lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            
            let tap = UITapGestureRecognizer()
            tap.rx.event.subscribe(onNext: { [unowned self](_) in
                let vc = MyTransactionController.instantIntializeController(storyBoardName: "Main")!
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: self.bag)
            self.transaction.addGestureRecognizer(tap)
        }
        
        do {
            
            let tap = UITapGestureRecognizer()
            tap.rx.event.subscribe(onNext: { (_) in
                //TODO
                guard let vc = UIApplication.shared.keyWindow?.rootViewController as? CustomTabBarController else { return }
                vc.selectedIndex = 0
                
            }).disposed(by: self.bag)
            self.propertyCombo.addGestureRecognizer(tap)
        }
        
        do {
            let tap = UITapGestureRecognizer()
            tap.rx.event.subscribe(onNext: { [unowned self](_) in
                let vc = UIAlertController(title: "温馨提示", message: "還未購買這個產品", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil)
                vc.addAction(action)
                self.present(vc, animated: true, completion: nil)
            }).disposed(by: self.bag)
            self.insruence.addGestureRecognizer(tap)
        }
        
        do {
            let tap = UITapGestureRecognizer()
            tap.rx.event.subscribe(onNext: { [unowned self](_) in
                let vc = UIAlertController(title: "温馨提示", message: "還未購買這個產品", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil)
                vc.addAction(action)
                self.present(vc, animated: true, completion: nil)
            }).disposed(by: self.bag)
            self.stableProfit.addGestureRecognizer(tap)
        }
        
        do {
            self.editPassword.rx.tap.asObservable().subscribe(onNext: { [unowned self](_) in
                let vc = EditPasswordController.instantIntializeController(storyBoardName: "SigninController")!
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: self.bag)
            
            self.idButton.isUserInteractionEnabled = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidenavgationBar()
        if UserManager.shared.isSignin {
            UserManager.shared.syncRemote().subscribe(onNext: { (user) in
                self.view.isHidden = false
                self.name.text = user.name
                let str: String = user.cardno
                self.idButton.setTitle("ID:\(str)", for: .normal)
                self.properyBalance.text = Float(user.currentAssets / 100).currency()
            }).disposed(by: self.bag)
        } else {
            self.view.isHidden = false
            RootVcManager.shared.switch(type: RootType.unsign)
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        DebugLog("\(self) deinit")
    }
    @IBOutlet weak var properyBalance: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var idButton: UIButton!
    @IBOutlet weak var editPassword: UIButton!
    @IBOutlet weak var transaction: UIView!
    @IBOutlet weak var propertyCombo: UIView!
    @IBOutlet weak var insruence: UIView!
    @IBOutlet weak var stableProfit: UIView!
    var bag : DisposeBag = DisposeBag()
    
}

