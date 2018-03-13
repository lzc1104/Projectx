//
//  MyTransactionController.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/20.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MyTransactionController: UIViewController,StoryLoadable {

    //MARK: lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self._initialSubViews()
        self._layoutConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadCombo.onNext()
        self.showNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        DebugLog("\(self) deinit")
    }
    //MARK: -Private Layout
    private func _initialSubViews() {
        
        self.navigationItem.title = "资金管理"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.separatorStyle = .none
        
        self.tableView.rx.contentOffset
            .filter({ $0.y < -30 })
            .toVoid()
            .bind(to: self.loadCombo)
            .disposed(by: self.bag)
        
        
        self.loadCombo
            .flatMapLatest { _ -> Observable<Result<PBTransactionList>> in
                let req = PBTransactionListReq()
                req.userId = UserManager.shared.user.id_p
                return self.service.apiForUserTransactionList(req: req)
            }
            .loading()
            .flatMapLatest {
                $0.asObservable()
                    .toastError()
                    .catchErrorJustReturnEmpty()
            }
            .hideLoading()
            .map({ list -> [PBTransaction] in list.transactionsArray.genericsMap() })
            .bind(to: self.combos)
            .disposed(by: self.bag)
        
        
        self.combos.asObservable().subscribe(onNext: { [unowned self](transactions) in
            self.tableView.reloadData()
        }).disposed(by: self.bag)
        
    }
    
    private func _layoutConstraints() {
        
    }
    
    var bag : DisposeBag = DisposeBag()
    var loadCombo: PublishSubject<Void> = PublishSubject()
    var service: BussinessService = BussinessService()
    @IBOutlet weak var tableView: UITableView!
    var combos: Variable<[PBTransaction]> = Variable([])
    
}

extension MyTransactionController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.combos.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
        
    }
}

extension MyTransactionController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.combos.value[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyTransactionCell
        cell.transaction = model
        return cell
    }
    
    
}

class MyTransactionCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var withDrawButton: UIButton!
    
    var transaction: PBTransaction? {
        didSet {
            guard let tc = self.transaction else { return }
            self.nameLabel.text = tc.portfolio.name
            
            self.valueLabel.text = Float(tc.portfolio.price / 100).currency()
            let formatter = XDateFormat("yyyy/MM/dd")
            self.timeLabel.text = formatter(tc.startDate / 1000)
            self.withDrawButton.rx.tap.asObservable().subscribe(onNext: { (_) in
                let vc = UIAlertController(title: "温馨提示", message: "投資期限未完成", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil)
                vc.addAction(action)
                UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
            }).disposed(by: self.bag)
            
            
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bag = DisposeBag()
    }
    
    var bag : DisposeBag = DisposeBag()
    
    
    
}

extension Float {
    func currency() -> String {
        let num = NSNumber(floatLiteral: Double(self))
        let formateer = NumberFormatter.init()
        formateer.numberStyle = .currency
        return formateer.string(from: num) ?? ""
    }
}

func XDateFormat(_ template: String) -> (UInt64) -> String {
    return { timeStamp in
        let date = Date.init(timeIntervalSince1970: TimeInterval(timeStamp))
        let formatter = DateFormatter()
        formatter.dateFormat = template
        let textString = formatter.string(from: date)
        return textString
    }
}
