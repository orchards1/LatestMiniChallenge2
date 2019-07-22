//
//  runViewController.swift
//  MiniChallenge2
//
//  Created by Michael Louis on 22/07/19.
//  Copyright © 2019 Michael Louis. All rights reserved.
//

import UIKit
import CoreMotion

class runViewController: UIViewController {
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    let calendar = Calendar.current
    let currDate = UserDefaults.standard.string(forKey: "currentdate")
    let pedometer = CMPedometer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        CMPedometer.isDistanceAvailable()
        CMPedometer.isPaceAvailable()
        
        let startExercise = formatter.date(from: currDate ?? "")
        pedometer.startUpdates(from: startExercise ?? Date() ) { data, error in
            guard let activityData = data, error == nil else {
                print("There was an error getting the data: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.distanceLabel.text =  String(format:"%.2f", (Double(activityData.distance ?? 0)/1000))
                self.paceLabel.text = String(format:"%.2f", (Double(activityData.currentPace ?? 0)))
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Run"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
