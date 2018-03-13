//
//  EditPasswordController.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/15.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CommonLib
import MBProgressHUD

class EditPasswordController: UIViewController,StoryLoadable {

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
        
        
        self.navigationItem.title = "修改密码"
        
        let wrap = Observable.combineLatest(self.codeField.rx.text.orEmpty, self.oldPasswordField.rx.text.orEmpty,self.newPasswordField.rx.text.orEmpty, resultSelector: { ($0,$1,$2) })
        
        let check = Observable.combineLatest(self.newPasswordField.rx.text.orEmpty, self.confirmNewpasswordField.rx.text.orEmpty, resultSelector: {($0,$1)}).map({ $0 == $1 && !$0.isEmpty })
        let textSet: [Observable<Bool>] = [
            self.codeField.rx.text.orEmpty.map{ !$0.isEmpty },
            self.oldPasswordField.rx.text.orEmpty.map{ !$0.isEmpty },
            self.newPasswordField.rx.text.orEmpty.map{ !$0.isEmpty },
            self.confirmNewpasswordField.rx.text.orEmpty.map{ !$0.isEmpty }
            
        ]
        
        Observable.combineLatest(textSet)
            .map({ $0.reduce(true, { $0.0 && $0.1 }) })
            .bind(to: self.confirm.rx.isEnabled)
            .disposed(by: self.bag)
        
        
        confirm.rx.tap.asObservable()
            .withLatestFrom(check)
            .toastIfFalse("请输入相同密码")
            .filter({ $0 })
            .withLatestFrom(wrap)
            .map({ return ($1,$2) })
            .map(PBResetPasswordReq.with)
            .loading()
            .flatMapLatest(self.service.apiForUserReset)
            .flatMapLatest {
                $0.asObservable()
                    .toastError()
                    .hideLoading()
                    .catchErrorJustReturnEmpty()
            }
            .hideLoading()
            .do(onNext: UserManager.shared.save)
            .toVoid()
            .subscribe(onNext: self.pop)
            .disposed(by: self.bag)
        
        
        do {
            let btn = UIButton()
            btn.setTitleColor(.white, for: .normal)
            btn.setTitle("退出", for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            btn.sizeToFit()
            let item = UIBarButtonItem(customView: btn)
            self.navigationItem.rightBarButtonItem = item
            btn.rx.tap.asObservable().subscribe(onNext: { [unowned self](_) in
                let vc = UIAlertController(title: "温馨提示", message: "确定退出7？", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "取消", style: UIAlertActionStyle.default, handler: nil)
                let action1 = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { _ in
                    UserManager.shared.userLogout()
                    RootVcManager.shared.switch(type: RootType.sign)
                    
                })
                
                vc.addAction(action)
                vc.addAction(action1)
                self.present(vc, animated: true, completion: nil)
            }).disposed(by: self.bag)
        }
    }
    
    func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    private func _layoutConstraints() {
        
    }
    
    deinit {
        DebugLog("\(self) deinit")
    }
    
    var service: BussinessService = BussinessService()
    var bag : DisposeBag = DisposeBag()
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var oldPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var confirmNewpasswordField: UITextField!
    @IBOutlet weak var codeField: UITextField!

}

extension PBResetPasswordReq {
    static func with(oldPassword: String , newPassword: String ) -> PBResetPasswordReq {
        let req = PBResetPasswordReq()
        req.userId = UserManager.shared.user.id_p
        req.oldPassword = oldPassword
        req.newPassword = newPassword
        return req
    }
    
}


extension Observable {
    
    func toVoid() -> Observable<Void> {
        return self.map({ _ in return () })
    }
    
    func loading() -> Observable<E> {
        return self.do(onNext: { (_) in
            LOADING()
        })
    }
    
    func hideLoading() -> Observable<E> {
    
        return self.do(onNext: { (_) in
            HIDE_LOADING()
        }, onError: { (_) in
            HIDE_LOADING()
        })
    }
    
}

extension Observable where E == Bool {
    func toastIfFalse(_ text: String) -> Observable<Bool> {
        return self.do(onNext: { (isValid) in
            if !isValid {
                Toast(text)
            }
        })
    }
    
    
}

func Toast(_ text: String) {
    print(text)
    POSTMSG(text)
    
}
