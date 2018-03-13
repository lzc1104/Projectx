//
//  PropertyComboController.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/15.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PropertyComboController: UIViewController {

    //MARK: lift cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self._initialSubViews()
        self._layoutConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadCombo.onNext()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
        DebugLog("\(self) deinit")
    }
    //MARK: -Private Layout
    private func _initialSubViews() {
        
        self.navigationItem.title = "创新金融投资"
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
        
        
        self.loadCombo.flatMapLatest { _ -> Observable<Result<PBPortfolioList>> in
                let req = PBPortfolioListReq()
                if UserManager.shared.isSignin {
                    req.userId = UserManager.shared.user.id_p
                }
                return self.service.apiForProfiProduct(req: req)
            }
            .loading()
            .flatMapLatest {
                $0.asObservable()
                    .toastError()
                    .catchErrorJustReturnEmpty()
            }
            .hideLoading()
            .map({ list -> [PBPortfolio] in list.portfoliosArray.genericsMap() })
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
    var combos: Variable<[PBPortfolio]> = Variable([])
    

}

extension PropertyComboController : UITableViewDelegate {
    
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

extension PropertyComboController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.combos.value[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PropertyComboCell
        cell.portfolio = model
        return cell
    }
    
    
}

class PropertyComboCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var portfolio: PBPortfolio? {
        didSet {
            guard let tc = self.portfolio else { return }
            self.nameLabel.text = tc.name
            self.valueLabel.text = Float(tc.price / 100).currency()
            let formatter = XDateFormat("yyyy/MM/dd")
            
            self.timeLabel.text = formatter(tc.endDate / 1000)
            
        }
    }
}
