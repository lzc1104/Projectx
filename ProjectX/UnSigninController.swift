//
//  UnSigninController.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/15.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UnSigninController: UIViewController,StoryLoadable {

    //MARK: lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidenavgationBar()
        self._initialSubViews()
        self._layoutConstraints()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidenavgationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        print("\(self) deinit")
    }
    
    
    //MARK: -Private Layout
    private func _initialSubViews() {
        self.signInButton.rx.tap.asObservable()
            .subscribe(onNext: { (_) in
                let vc = SigninController.instantIntializeController(storyBoardName: "SigninController")!
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: self.bag)
    }
    
    private func _layoutConstraints() {
        
    }
    
    var bag : DisposeBag = DisposeBag()
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

}

extension UIViewController {
    func hidenavgationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
