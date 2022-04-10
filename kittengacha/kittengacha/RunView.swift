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
    @ObservedObject var screenNumber: Screens
    
    func fetchHealthData() -> Void {
        let healthStore = HKHealthStore()
        if HKHealthStore.isHealthDataAvailable() {
            let readData = Set([
                HKObjectType.quantityType(forIdentifier: .stepCount)!
            ])
            
            healthStore.requestAuthorization(toShare: [], read: readData) { (success, error) in
                if success {
                    print(screenNumber.userStats.prevLogin)
                    let calendar = NSCalendar.current
                    
                    let anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: screenNumber.userStats.prevLogin)
                    
                    guard let anchorDate = Calendar.current.date(from: anchorComponents) else {
                        fatalError("*** unable to create a valid date from the given components ***")
                    }
                    
                    let interval = NSDateComponents()
                    interval.minute = 2
                    
                    let endDate = screenNumber.userStats.currLogin
                                                
                    let startDate = screenNumber.userStats.prevLogin
                                        
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
                        guard let statsCollection = results else {
                            fatalError("*** An error occurred while calculating the statistics: \(String(describing: error?.localizedDescription)) ***")
                        }
                                            
                        statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
                            if let quantity = statistics.sumQuantity() {
                                let value = quantity.doubleValue(for: HKUnit.count())
                                screenNumber.userStats.steps += value
                            }
                        }
                    }
                    healthStore.execute(query)
                } else {
                    print("Authorization failed")
                }
            }
        }
        screenNumber.userStats.prevLogin = screenNumber.userStats.currLogin
        screenNumber.userStats.currLogin = Date().addingTimeInterval(TimeInterval(-14400))
        print(screenNumber.userStats.steps)
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encodedUser = try? encoder.encode(screenNumber.userStats) {
            defaults.set(encodedUser, forKey: "user")
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image("clouds")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 16)
                HStack {
                    Text("\(Int(screenNumber.userStats.steps)) total steps")
                        .frame(width: UIScreen.main.bounds.width / 5 * 2, height: UIScreen.main.bounds.height / 32)
                        .font(.body)
                        .padding(.bottom)
                    
                }
            }
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .ignoresSafeArea()
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
            ZStack {
                Image("clouds")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 16)
                HStack(alignment: .center) {
                    Button("Run") {
                        screenNumber.screenNumber = 3
                    }
                    .padding(.leading, UIScreen.main.bounds.width / 8)
                    .offset(y: UIScreen.main.bounds.height / 80)
                    Spacer()
                    Button("Pull") {
                        screenNumber.screenNumber = 0
                    }
                    .padding(.leading, UIScreen.main.bounds.width / 20)
                    .offset(y: UIScreen.main.bounds.height / 80)
                    Spacer()
                    Button("Collection") {
                        screenNumber.screenNumber = 1
                    }
                    .padding(.trailing, UIScreen.main.bounds.width / 16)
                    .offset(y: UIScreen.main.bounds.height / 80)
                }
            }

            .foregroundColor(Color.black)
        }.onAppear(perform: fetchHealthData)
    }
}
