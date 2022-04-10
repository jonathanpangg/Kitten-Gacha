//
//  PullView.swift
//  kittengacha
//
//  Created by Jason Kwan on 4/9/22.
//

import Foundation
import SwiftUI

struct PullView: View {
    @State var test: String = ""
    @State var pc: String = ""
    var cat = Cats()
    @ObservedObject var screenNumber: Screens
    
    var body: some View {
        HStack {
            Button("Convert Steps") {
                screenNumber.screenNumber = 2
            }
        }
        VStack {
            Button("Collection") {
                screenNumber.screenNumber = 1
            }
            Button("Pull") {
                test = cat.catPuller()
                pc = "Your current pity is: " + String(cat.pullCount)
            }
            .padding(.top)
            Text(pc)
            Text(test)
            Spacer()
            Image(test)
                .resizable()
                .scaledToFit()
            
        }
        ZStack {
            Image("cloud")
                .resizable()
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 16)
            HStack(alignment: .center) {
                Button("Run") {
                    screenNumber.screenNumber = 3
                }
                .padding(.leading, UIScreen.main.bounds.width / 8)
                Spacer()
                Button("Pull") {
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
}
