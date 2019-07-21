//
//  InterfaceController.swift
//  MiniChallenge2 WatchKit Extension
//
//  Created by Michael Louis on 11/07/19.
//  Copyright © 2019 Michael Louis. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBAction func startButtonPressed() {
        TimerLabel.start()
    }
    @IBOutlet weak var TimerLabel: WKInterfaceTimer!
    @IBOutlet weak var startButton: WKInterfaceButton!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
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
