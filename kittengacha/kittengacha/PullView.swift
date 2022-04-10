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
    @State var bg: String = ""
    var cat = Cats()
    @ObservedObject var screenNumber: Screens
    
    var body: some View {
        ScrollView {
            HStack {
                Button("Get More Adoptions") {
                    screenNumber.screenNumber = 2
                }
                .padding(.leading)
                Spacer()
                Button("Adopt") {
                    test = cat.catPuller()
                    pc = "\(cat.pullCount)"
                    screenNumber.userStats.collection.append(test)
                    let defaults = UserDefaults.standard
                    let encoder = JSONEncoder()
                    if let encodedUser = try? encoder.encode(screenNumber.userStats) {
                        defaults.set(encodedUser, forKey: "user")
                    }
                }
                .padding(.trailing)
            }
            .foregroundColor(Color.black)
            
            .padding(.top)
            Spacer()
            Divider()
            ZStack(alignment: .leading) {
            Image("background")
                .resizable()
                .scaledToFill()
                .clipped()
                .listRowInsets(EdgeInsets())
                Image(test)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                        
            }
                
            Divider()
            VStack() {
                Text(test)
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                        

                Divider()

                Text("Current Pity: \n" + String(pc))
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15)
            }
            .padding()
        }
        tabView(screenNumber)
    }
}
