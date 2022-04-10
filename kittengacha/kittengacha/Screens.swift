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

func tabView(_ screenNumber: Screens) -> some View {
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
            Spacer()
            Button("Adopt") {
                screenNumber.screenNumber = 0
            }
            .padding(.leading, UIScreen.main.bounds.width / 20)
            Spacer()
            Button("Collection") {
                screenNumber.screenNumber = 1
            }
            .padding(.trailing, UIScreen.main.bounds.width / 16)
        }
    }

    .offset(y: UIScreen.main.bounds.height / 96)
    .foregroundColor(Color.black)
}

class Variables: ObservableObject {
    @Published var pc: String = "0"
}
