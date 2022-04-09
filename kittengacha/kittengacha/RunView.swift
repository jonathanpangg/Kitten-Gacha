//
//  RunView.swift
//  kittengacha
//
//  Created by Jonathan Pang on 4/9/22.
//

import Foundation
import SwiftUI
import HealthKit
import MapKit

struct RunView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State var steps: Double = 0
    func fetchHealthData() -> Void {
        let healthStore = HKHealthStore()
        if HKHealthStore.isHealthDataAvailable() {
            let readData = Set([
                HKObjectType.quantityType(forIdentifier: .stepCount)!
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
                                                
                    let startDate = calendar.startOfDay(for: Date())
                                        
                    guard let quantityType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) else {
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
                                let value = quantity.doubleValue(for: HKUnit.count())
                                steps += value
                            }
                        }
                    }
                    healthStore.execute(query)
                } else {
                    print("Authorization failed")
                }
            }
        }
        
        print(steps)
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
