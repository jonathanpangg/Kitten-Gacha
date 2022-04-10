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
    
    var cat = Cats()
    
    @ObservedObject var screenNumber: Screens
    
    var body: some View {
        VStack {
            Spacer()
            if (Int(screenNumber.userStats.steps / 2000 ) == 0) {
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
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 15)
                    Image(systemName: "arrow.forward")
                        .font(.system(size: 56.0))
                    Image("paw print")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 5)
                }
                VStack {
                    Slider(value: $speed, in: 0...screenNumber.userStats.steps/2000 + 1, step: 1) {
                        Text("\(speed)")
                            .foregroundColor(isEditing ? .red : .blue)
                    }
                    minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text(String(screenNumber.userStats.steps/2000))
                    }
                    onEditingChanged: { editing in
                    isEditing = editing
                }
                .padding(.leading)
                .padding(.trailing)
                
                Button("Dec") {
                    screenNumber.userStats.steps -= 2000 * speed
                }
                    
                ZStack {
                    Image("button")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 15)
                    Text("Convert Steps")
                        .foregroundColor(.red)

                        }
            
                .padding(.top)
                Text(pc)
                Text(test)
                Image(test)
                    .resizable()
                    .scaledToFit()
                }
            }
        }
    }
}
