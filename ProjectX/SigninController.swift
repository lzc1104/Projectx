//
//  SigninController.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/15.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SigninController: UIViewController,StoryLoadable {

    //MARK: lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self._initialSubViews()
        self._layoutConstraints()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: -Private Layout
    private func _initialSubViews() {
        
        self.navigationItem.title = "登录"
        
        let wrap = Observable.combineLatest(self.codeField.rx.text.orEmpty,
                                            self.passwordField.rx.text.orEmpty, resultSelector: { ($0,$1) }).shareReplayLatestWhileConnected()
        
        wrap.map({ !$0.0.isEmpty && !$0.1.isEmpty  })
            .bind(to: self.confirm.rx.isEnabled)
            .disposed(by: self.bag)
        
        
        confirm.rx.tap.asObservable()
            .withLatestFrom(wrap)
            .map(PBUser.with)
            .loading()
            .flatMapLatest({ (user) in
                return XApiRequest<PBUser,PBUser>(
                    request: user,
                    type: PBXMessageType.userLogin
                ).requestApi()
                
            })
            .hideLoading()
            .flatMapLatest {
                $0.asObservable()
                    .toastError()
                    .catchErrorJustReturnEmpty()
            }
            .subscribe(onNext: UserManager.shared.userLogin)
            .disposed(by: self.bag)
    }
    
    private func _layoutConstraints() {
        
    }
    
    deinit {
        DebugLog("\(self) deinit")
    }
    
    var service: BussinessService = BussinessService()
    var bag : DisposeBag = DisposeBag()
    
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var codeField: UITextField!
}

extension PBUser {
    class func with(carno: String , password: String) -> PBUser {
        let user = PBUser()
        user.cardno = carno
        user.password = password
        return user
    }
}


