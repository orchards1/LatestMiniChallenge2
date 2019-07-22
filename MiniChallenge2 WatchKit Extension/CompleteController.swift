//
//  CompleteController.swift
//  MiniChallenge2 WatchKit Extension
//
//  Created by Marcel W on 22/07/19.
//  Copyright © 2019 Michael Louis. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion


class CompleteController: WKInterfaceController {

    let pedometer = CMPedometer()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        pedometer.stopUpdates()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
