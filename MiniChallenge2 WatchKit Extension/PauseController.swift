//
//  PauseController.swift
//  MiniChallenge2 WatchKit Extension
//
//  Created by Marcel W on 21/07/19.
//  Copyright © 2019 Michael Louis. All rights reserved.
//

import WatchKit
import UIKit

class PauseController: WKInterfaceController {
    
    var afterStartController = AfterStartController()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        self.setTitle(context as? String)
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
        
       presentController(withName: "page1", context: "Done")
    }
    
    
}
