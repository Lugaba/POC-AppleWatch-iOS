//
//  Counter.swift
//  watchTeste2
//
//  Created by Luca Hummel on 24/10/22.
//

import Foundation
import WatchConnectivity

class Counter: NSObject, ObservableObject {
    @Published var num: Int = 0
    
    override init() {
        super.init()
        self.start()
    }
    
    func start() {
        guard WCSession.isSupported() else {
            return
        }
        WCSession.default.delegate = self
        WCSession.default.activate()
    }
    
    func descrease() {
        self.num -= 1
        self.send(value: self.num)
    }
    
    func increase() {
        self.num += 1
        self.send(value: self.num)
    }
    
    func send(value: Int) {
        guard WCSession.default.activationState == .activated else {
            return
        }
        
#if os(watchOS)
        guard WCSession.default.isCompanionAppInstalled else {
            return
        }
#else
        guard WCSession.default.isWatchAppInstalled else {
            return
        }
#endif
        
        let userInfo: [String : Int] = ["value": value]
        
        WCSession.default.sendMessage(userInfo, replyHandler: nil)
    }
}

extension Counter: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
#if !os(watchOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
#endif
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        for messageValue in message.values {
            DispatchQueue.main.async {
                self.num = messageValue as! Int
            }
        }
    }
}
