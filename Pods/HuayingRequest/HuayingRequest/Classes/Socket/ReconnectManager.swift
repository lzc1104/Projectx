//
//  ReconnectManager.swift
//  Pods
//
//  Created by lzc1104 on 2017/9/14.
//
//

import Foundation

public class ReconnectManager {
    
    public enum ReconnectType {
        case fixed(Int)
        case randomRange(CountableClosedRange<Int>)
        
        public var description: String {
            switch self {
            case .fixed(let time):
                return "\(time) seconds"
            case .randomRange(let range):
                return "range between \(range.lowerBound) ~ \(range.upperBound)  seconds"
            }
        }
        
    }
    
    ///MARK: - hook
    public var tryReconnect: ((Int) -> Void)?
    ///MARK: - Public protperties
    public var isEnabled: Bool {
        return self._isEnabled
    }
    public var type: ReconnectType {
        return self._type
    }
    public var delaySeconds: Int {
        return self._delaySeconds
    }
    ///MARK: - Private protperties
    private var _isEnabled: Bool = true
    private var _type: ReconnectType
    private var retryTime: Int = 0
    private var _delaySeconds: Int = 0
    private var timer: DispatchSourceTimer? {
        didSet {
            oldValue?.cancel()
        }
    }
    private lazy var operationQueue: DispatchQueue = {
        let label = UUID().uuidString
        return DispatchQueue(label: "com.huayingReconnect.timer\(label)")
    }()
    
    
    public init(type: ReconnectType) {
        self._type = type
        self._isEnabled = true
    }
    
    /// 递归执行重连任务
    public func beginReconnect() {
        self.stopReconnect()
        self._isEnabled = true
        self.delayReconnect()
    }
    
    /// 停止重连任务
    public func stopReconnect() {
        self._isEnabled = false
        self.timer = nil
        self.retryTime = 0
        self._delaySeconds = 0
    }
    
    private func delayReconnect() {
        guard self.isEnabled else { return }
        let delayTime: DispatchTimeInterval
        switch self._type {
        case .fixed(var time):
            self._delaySeconds = time
            time = max(1,time)
            delayTime = DispatchTimeInterval.seconds(time)
        case .randomRange(let range):
            let seed = arc4random_uniform(100)
            var seconds = (range.upperBound - range.lowerBound) * Int(seed) / 100 + range.lowerBound
            seconds = max(1,seconds)
            delayTime = DispatchTimeInterval.seconds(seconds)
            self._delaySeconds = seconds
        }
        let timer = DispatchSource.makeTimerSource()
        timer.scheduleOneshot(deadline: .now() + delayTime)
        timer.setEventHandler {
            guard self.isEnabled else { return }
            self.executeReconnect()
            //recurise
            self.delayReconnect()
        }
        timer.resume()
        self.timer = timer
        
    }
    
    private func executeReconnect() {
        self.retryTime += 1
        self.tryReconnect?(self.retryTime)
    }
    
    deinit {
        DPrint("ReconnectManager deinit")
    }
    
    
}
