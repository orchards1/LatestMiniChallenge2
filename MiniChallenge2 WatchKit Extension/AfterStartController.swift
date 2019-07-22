//
//  afterStartController.swift
//  MiniChallenge2 WatchKit Extension
//
//  Created by Marcel W on 21/07/19.
//  Copyright © 2019 Michael Louis. All rights reserved.
//

import WatchKit
import UIKit
import HealthKit
import WatchConnectivity
import CoreMotion

class AfterStartController: WKInterfaceController {
    
    @IBOutlet weak var timerLabel: WKInterfaceTimer!
    @IBOutlet weak var distanceLabel: WKInterfaceLabel!
    @IBOutlet weak var calorieLabel: WKInterfaceLabel!
    @IBOutlet weak var bpmLabel: WKInterfaceLabel!
    
    let healthStore = HKHealthStore()
    let configuration = HKWorkoutConfiguration()
    let calendar = Calendar.current
    
    let pedometer = CMPedometer()
    var countsDistance = 0.0
    var countsCalorie = 0.0
    var countsHeartRate = 0.0
    
    let currDate = UserDefaults.standard.string(forKey: "currentdate")
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
//        var attributedText = NSMutableAttributedString(string: String(format: "%.2f", self.counts/1000), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 50.0, weight: UIFont.Weight.bold)])
//
//        attributedText.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 50.0)], range: NSRange(location: 1, length: 5))
        
        configuration.activityType = .running
        
        let earlyDate = calendar.startOfDay(for: Date())
        
        CMPedometer.isDistanceAvailable()
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        let startExercise = formatter.date(from: currDate ?? "")
        pedometer.startUpdates(from: startExercise ?? Date() ) { data, error in
            guard let activityData = data, error == nil else {
                print("There was an error getting the data: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.distanceLabel.setText( String(format:"%.2f", (Double(activityData.distance ?? 0)/1000)))
            }
        }
        
        checkHealthKitAuthorization()
        
//        fetchDistance(endTime: NSDate() , startTime: calendar.startOfDay(for: Date()) as NSDate)
        fetchCalorie(endTime: NSDate(), startTime: calendar.startOfDay(for: Date()) as NSDate)
        fetchHeartRates(endTime: NSDate(), startTime: calendar.startOfDay(for: Date()) as NSDate)
        timerLabel.start()
        self.setTitle(context as? String)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        checkHealthKitAuthorization()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    func checkHealthKitAuthorization() {
        
        if HKHealthStore.isHealthDataAvailable(){
            let infoToRead = Set([HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning), HKSampleType.quantityType(forIdentifier: .activeEnergyBurned), HKSampleType.quantityType(forIdentifier: .heartRate), HKSampleType.quantityType(forIdentifier: .stepCount)])
            let infoToShare = Set([HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning), HKObjectType.quantityType(forIdentifier: .activeEnergyBurned), HKObjectType.quantityType(forIdentifier: .heartRate), HKObjectType.quantityType(forIdentifier: .stepCount)])
            
            healthStore.requestAuthorization(toShare: infoToShare as? Set<HKSampleType>, read: infoToRead as? Set<HKObjectType>) { (success, error) in
                //something
                print("succeeded")
            }
        }else{
            
        }
    }

    func fetchCalorie(endTime: NSDate, startTime: NSDate){
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else { return }
        let predicate = HKQuery.predicateForSamples(withStart: startTime as Date, end: endTime as Date, options: [])
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 10000, sortDescriptors: [sortDescriptor])
        { (query, results, error) in
            if error != nil {
                print("An error has occured with the following description: \(error?.localizedDescription)")
            } else {
                for r in results! {
                    let result = r as! HKQuantitySample
                    let quantity = result.quantity
                    let count = quantity.doubleValue(for: .kilocalorie())
                    self.countsCalorie = self.countsCalorie + count
                    DispatchQueue.main.async {
                        self.calorieLabel.setText(String(format: "%.0f kcal", self.countsCalorie))
                        
                    }
                    
                }
            }
        }
        healthStore.execute(query)
    }
    
    func fetchHeartRates(endTime: NSDate, startTime: NSDate){
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
        let predicate = HKQuery.predicateForSamples(withStart: startTime as Date, end: endTime as Date, options: [])
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 100, sortDescriptors: [sortDescriptor])
        { (query, results, error) in
            if error != nil {
                print("An error has occured with the following description: \(error?.localizedDescription)")
            } else {
                for r in results! {
                    let result = r as! HKQuantitySample
                    let quantity = result.quantity
                    let count = quantity.doubleValue(for: HKUnit(from: "count/min"))
                    self.countsHeartRate = self.countsHeartRate + count
                    DispatchQueue.main.async {
                        self.bpmLabel.setText(String(format: "%.0f bpm", count))
                        
                        
                    }
                    
                }
            }
        }
        healthStore.execute(query)
    }
    
    
}

//    func fetchDistance(endTime: NSDate, startTime: NSDate){
//        guard let sampleType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) else { return }
//        let predicate = HKQuery.predicateForSamples(withStart: startTime as Date, end: endTime as Date, options: [])
//        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
//
//        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 10000, sortDescriptors: [sortDescriptor])
//        { (query, results, error) in
//            if error != nil {
//                print("An error has occured with the following description: \(error?.localizedDescription)")
//            } else {
//                for r in results! {
//                    let result = r as! HKQuantitySample
//                    let quantity = result.quantity
//                    let count = quantity.doubleValue(for: .meter())
//                    self.countsDistance = self.countsDistance + count
//                    DispatchQueue.main.async {
//                        self.distanceLabel.setAttributedText(NSAttributedString(string: String(format: "%.2f", self.countsDistance/1000), attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 55.0)]))
//
//                    }
//
//                }
//            }
//        }
//        healthStore.execute(query)
//    }
