//
//  PullConversionView.swift
//  kittengacha
//
//  Created by Jason Kwan on 4/9/22.
//

import Foundation
import SwiftUI
import UIKit



struct PullConversionView: View {
    
    @State private var speed: Double = 0
    @State private var isEditing = false
    
    @State var test: String = ""
    @State var pc: String = ""
    @State var numPaws = 0
    var cat = Cats()
    
    @ObservedObject var screenNumber: Screens
    func testing() {
            screenNumber.userStats.steps = 21050
        }
    var body: some View {
        VStack {
            VStack {
                Text("\(Int(screenNumber.userStats.steps)) total steps")
                Text("\(Int(numPaws)) total paws")
            }
            Spacer()
            if (Int(screenNumber.userStats.steps / 2000 ) <= 0) {
                GifImage("crying")
                    .offset(y: UIScreen.main.bounds.height / 4)
                Text("You do not have enough steps to convert into Paw Prints")
                    .foregroundColor(.cyan)
                    .padding(.bottom, UIScreen.main.bounds.height / 8)
            }
            else {
                HStack {
                    Image("foot")
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(width: 100)
                    Image(systemName: "arrow.forward")
                        .font(.system(size: 56.0))
                    Image("paw print")
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(width: 100)
                }
                VStack {
                    Slider(value: $speed, in: 0...screenNumber.userStats.steps/2000, step: 1) {
                        Text("\(speed)")
                            .foregroundColor(isEditing ? .red : .blue)
                    }
                    minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text(String(Int(screenNumber.userStats.steps/2000)))
                    }
                    onEditingChanged: { editing in
                        isEditing = editing
                    }
                    .padding(.leading)
                    .padding(.trailing)
                                
                ZStack {
                    Image("button")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 15)
                    Button("Convert Steps") {
                        screenNumber.userStats.steps -= 2000 * speed
                        let defaults = UserDefaults.standard
                        let encoder = JSONEncoder()
                        if let encodedUser = try? encoder.encode(screenNumber.userStats) {
                            defaults.set(encodedUser, forKey: "user")
                        }
                        numPaws += Int(speed)
                        speed = 0
                    }
                    .foregroundColor(Color.white)
                }
                .padding(.top)
                Text(test)
            }
        }
            tabView(screenNumber)
        }.onAppear(perform: testing)
    }
}
