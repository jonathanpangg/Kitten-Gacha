//
//  ContentView.swift
//  kittengacha
//
//  Created by Jonathan Pang on 4/9/22.
//
 
import SwiftUI
import MapKit
import HealthKit

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    func getTodaySteps() {
        guard let sampleType = HKCategoryType.quantityType(forIdentifier: .stepCount) else { print("failed"); return }
        
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        var interval = DateComponents()
        interval.day = 1
        let query = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: endDate, options: [.cumulativeSum], anchorDate: startDate, intervalComponents: interval)
        
        query.initialResultsHandler = {
            query, result, error in
            
            if let myResult = result {
                myResult.enumerateStatistics(from: startDate, to: Date()) { (statistic, value) in
                    if let count = statistic.sumQuantity() {
                        let val = count.doubleValue(for: HKUnit.count())
                        print("here")
                        print(val)
                    }
                    else {
                        print("failed")
                    }
                }
            }
            
        }
        HKHealthStore().execute(query)
    }
    
    func fetchHealthData() -> Void {
        let healthStore = HKHealthStore()
        if HKHealthStore.isHealthDataAvailable() {
            let readData = Set([
                HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
            ])
            
            healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
                if success {
                    let calendar = NSCalendar.current
                    
                    var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: NSDate() as Date)
                    
                    let offset = (7 + anchorComponents.weekday! - 2) % 7
                    
                    anchorComponents.day! -= offset
                    anchorComponents.hour = 2
                    
                    guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
                        fatalError("*** unable to create a valid date from the given components ***")
                    }
                    
                    let interval = NSDateComponents()
                    interval.minute = 30
                                        
                    let endDate = Date()
                                                
                    guard let startDate = calendar.date(byAdding: .month, value: -1, to: endDate) else {
                        fatalError("*** Unable to calculate the start date ***")
                    }
                                        
                    guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning) else {
                        fatalError("*** Unable to create a step count type ***")
                    }
     
                    let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                                            quantitySamplePredicate: nil,
                                                                options: .cumulativeSum,
                                                                anchorDate: anchorDate,
                                                                intervalComponents: interval as DateComponents)
                    
                    query.initialResultsHandler = {
                        query, results, error in
                        print(results!)
                        guard let statsCollection = results else {
                            fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
                            
                        }
                                            
                        statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                            if let quantity = statistics.sumQuantity() {
                                let date = statistics.startDate
                                //for: E.g. for steps it's HKUnit.count()
                                let value = quantity.doubleValue(for: HKUnit.count())
                                print("done")
                                print(value)
                                print(date)
                            }
                            else {
                                print("failed")
                            }
                        }
                    }
                    healthStore.execute(query)
                } else {
                    print("Authorization failed")
                }
            }
        }
    }

    var body: some View {
        VStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
            HStack {
                Button("Press") {
                    fetchHealthData()
                }
                .frame(width: UIScreen.main.bounds.width / 5 * 2, height: UIScreen.main.bounds.height / 32)
                Button("Press") {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
                .frame(width: UIScreen.main.bounds.width / 5 * 2, height: UIScreen.main.bounds.height / 32)
            }
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
