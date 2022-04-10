//
//  Screens.swift
//  kittengacha
//
//  Created by Jason Kwan on 4/9/22.
//

import Foundation
import SwiftUI

class Screens: ObservableObject {
    @Published var screenNumber = 0
    @Published var userStats = UserStats()
    
    init() {
        let defaults = UserDefaults.standard
        
        if let savedUserData = defaults.object(forKey: "user") as? Data {
            let decoder = JSONDecoder()
            if let savedUser = try? decoder.decode(UserStats.self, from: savedUserData) {
                userStats = savedUser
            }
        }
    }
}
