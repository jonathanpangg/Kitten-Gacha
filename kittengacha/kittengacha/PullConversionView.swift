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
        GifImage("crying")
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
            Spacer()
            
            HStack {
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

            }
            .padding(.leading)
            .padding(.trailing)
            
            Button(action: {
            }, label: {
                
                ZStack {
                    Image("button")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 15)
                    Text("Convert Steps")
                        .foregroundColor(.red)

                }
            })
        Spacer()
        Text("You have ")
        .padding(.top)
        Text(pc)
        Text(test)
        Image(test)
            .resizable()
            .scaledToFit()
        }
    }
}
