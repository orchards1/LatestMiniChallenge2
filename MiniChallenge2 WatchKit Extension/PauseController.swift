//
//  PauseController.swift
//  MiniChallenge2 WatchKit Extension
//
//  Created by Marcel W on 21/07/19.
//  Copyright © 2019 Michael Louis. All rights reserved.
//

import WatchKit
import UIKit
import WatchConnectivity

class PauseController: WKInterfaceController, WCSessionDelegate {
    
    
    
    let session = WCSession.default
    
    let testing = String()
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated{
            do {
                try session.updateApplicationContext(["" : (Any).self])
            } catch {
                print("Something went wrong")
            }
        }
        
    }
    
    
    
    var afterStartController = AfterStartController()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        self.setTitle(context as? String)
        session.delegate = self
        session.activate()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func btnActPause() {
        
      WKInterfaceController.reloadRootControllers(withNames: ["pageComplete"], contexts: [])
    }
    
//    func sendGyroAccData() {
//
//        if self.session.isReachable {
//            let jsonData = try! JSONEncoder().encode(AfterStartController.)
//            self.session.sendMessageData(jsonData, replyHandler: { (data) in
//
//            }) { (error) in
//                self.titleLabel.setText("Error: \(error)")
//            }
//        }
//    }
    
}
