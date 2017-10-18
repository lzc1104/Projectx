//
//  BussinessService.swift
//  ProjectX
//
//  Created by lzc1104 on 2017/10/18.
//  Copyright © 2017年 ProjectX. All rights reserved.
//

import UIKit
import RxSwift
import HuayingRequest

enum Result<T > {
    case success(T)
    case failure(Error)
}


class BussinessService: XNetworkService {
    
    func apiForConfigGet() -> Observable<Result<PBAppConfig>> {
        return self.pbRequest(messageType: PBXMessageType.appConfigGet, pbmessage: nil)
    }
    
    func apiForUserLogin(req: PBUser) -> Observable<Result<PBUser>> {
        return self.pbRequest(messageType: PBXMessageType.userLogin, pbmessage: req)
    }
    func apiForUserReset(req: PBResetPasswordReq) -> Observable<Result<PBUser>> {
        return self.pbRequest(messageType: PBXMessageType.userResetPwd, pbmessage: req)
    }
    
    func apiForUserSync(req: PBUser) -> Observable<Result<PBUser>> {
        return self.pbRequest(messageType: PBXMessageType.userSync, pbmessage: req)
    }
    
    func apiForProfiProduct(req: PBPortfolioListReq) -> Observable<Result<PBPortfolioList>> {
        return self.pbRequest(messageType: PBXMessageType.portfolioGetList, pbmessage: req)
    }
    
    func apiForUserTransactionList(req: PBTransactionListReq) -> Observable<Result<PBTransactionList>> {
        return self.pbRequest(messageType: PBXMessageType.transactionGetList, pbmessage: req)
    }
    
    
}


extension XNetworkService {
    func pbRequest<T : GPBMessage>
        (messageType : PBXMessageType,
         pbmessage : GPBMessage?)
        -> Observable<Result<T>> {
            return Observable.create { (observer) -> Disposable in
                self.response(type: UInt32(messageType.rawValue), message: pbmessage, accessory: nil, completed: { (result: AFResult<T>) in
                    switch result {
                    case .success(let value):
                        observer.onNext(.success(value))
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onNext(.failure(error))
                        break
                    }
                })
                
                
                return Disposables.create()
            }
    }
    
}

extension Result {
    func asObservable() -> Observable<T> {
        return Observable.create({ (observer) -> Disposable in
            switch self {
            case .success(let result):
                observer.onNext(result)
                observer.onCompleted()
            case .failure(let error):
                observer.onError(error)
            }
            return Disposables.create()
        })
    }
    
    
}

extension Observable {
    
    func justToastNext(_ text : String) -> Observable<E> {
        return self.do(onNext: { (_) in
//            POSTMSG(text)
        })
    }
    
    func toastError() -> Observable<E> {
        return self.do(onError: { (error) in
//            POSTMSG(error.localizeDescriptionStr())
            print(error)
        })
    }
    
    func catchErrorJustReturnEmpty() -> Observable<E> {
        return self.catchError({ _ in return Observable.empty() })
    }
}
