//
//  UserManager.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/18.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserManager {
    
    static let shared = UserManager()
    private var _user: PBUser?
    var service = BussinessService()
    var user: PBUser {
        return _user ?? PBUser()
    }
    var bag : DisposeBag = DisposeBag()
    var isSignin: Bool {
        return _user != nil
    }
    
    
    init() {
        loadUser()
    }
    
    func syncRemote() -> Observable<PBUser> {
        guard let _ = _user else {
            fatalError()
        }
        return service.apiForUserSync(req: _user!)
            .flatMapLatest {
                $0.asObservable()
                    .toastError()
                    .catchErrorJustReturnEmpty()
        }
        
    }
    
    func loadUser() {
        guard let data = UserDefaults.standard.data(forKey: "user") else { return }
        guard let user = try? PBUser.parse(from: data) else { return }
        UserDefaults.standard.synchronize()
        _user = user
        
    }
    
    func save(_ user: PBUser) {
        _user = user
        let data = user.data()
        UserDefaults.standard.setValue(data, forKey: "user")
        UserDefaults.standard.synchronize()
    }
    
    func userLogin(_ user: PBUser) {
        self.save(user)
        RootVcManager.shared.switch(type: RootType.sign)
    }
    
    func userLogout() {
        _user = nil
        UserDefaults.standard.setValue(nil, forKey: "user")
    }
    
    func clean() {
        _user = nil
        UserDefaults.standard.setValue(nil, forKey: "user")
        
    }
    
    
}


enum RootType {
    case sign
    case unsign
}

class RootVcManager {
    
    static let shared = RootVcManager()
    var bag : DisposeBag = DisposeBag()
    func `switch`(type: RootType) {
        switch type {
        case .sign:
            
            let vc = CustomTabBarController.instantIntializeController(storyBoardName: "Main")!
            UIApplication.shared.keyWindow?.rootViewController = vc
            UIApplication.shared.keyWindow?.window?.makeKeyAndVisible()
            
        case .unsign:
            
            let vc = UnSigninController.instantIntializeController(storyBoardName: "SigninController")!
            let nav = CustomNavigatioController(rootViewController: vc)
            UIApplication.shared.keyWindow?.rootViewController = nav
            UIApplication.shared.keyWindow?.makeKeyAndVisible()
            _ = vc.view
            vc.closeButton.rx.tap.asObservable().subscribe(onNext: { (_) in
                self.switch(type: RootType.sign)
            }).disposed(by: self.bag)
        }
    }
    
}
