//
//  CollectionView.swift
//  kittengacha
//
//  Created by Jason Kwan on 4/9/22.
//

import Foundation
import SwiftUI

struct CollectionView: View {
    @ObservedObject var screenNumber: Screens
    @State var hairlessCount = 0
    @State var samCount = 0
    @State var roccoCount = 0
    @State var greyCount = 0
    @State var blackCount = 0
    @State var orangeCount = 0
    @State var foodCount = 0
    @State var waterCount = 0
    
    func initalVals() {
        for i in screenNumber.userStats.collection {
            if i == "hairless cat" {
                hairlessCount += 1
            } else if i == "Rocco" {
                roccoCount += 1
            } else if i == "Sam" {
                samCount += 1
            } else if i == "grey cat" {
                greyCount += 1
            } else if i == "black cat" {
                blackCount += 1
            } else if i == "orange cat"{
                orangeCount += 1
            } else if i == "food" {
                foodCount += 1
            } else {
                waterCount += 1
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: -1.0) {
                HStack(spacing: -1.0) {
                    Tile(name: "hairless cat", num: hairlessCount)
                        .border(Color.black, width: 1.00)
                    Tile(name: "Rocco", num: roccoCount)
                        .border(Color.black, width: 1.00)
                }
               
                HStack(spacing: -1.0) {
                    Tile(name: "Sam", num: samCount)
                        .border(Color.black, width: 1.00)
                    Tile(name: "grey cat", num: greyCount)
                        .border(Color.black, width: 1.00)
                }
                HStack(spacing: -1.0) {
                    Tile(name: "black cat", num: blackCount)
                        .border(Color.black, width: 1.00)
                    Tile(name: "orange cat", num: orangeCount)
                        .border(Color.black, width: 1.00)
                }
                
                HStack(spacing: -1.0) {
                    Tile(name: "food", num: foodCount)
                        .border(Color.black, width: 1.00)
                    Tile(name: "water", num: waterCount)
                        .border(Color.black, width: 1.00)
                }
                .padding(.bottom, 15)
            }
        }
        tabView(screenNumber)
            .onAppear(perform: initalVals)
    }
}

struct Tile : View {
    var name: String
    var num: Int
    
    var body: some View {
        VStack {
            Spacer()
            Image(name)
                .resizable()
                .scaledToFit()
                .clipped()
                .listRowInsets(EdgeInsets())
            Text("\(num)")
                .multilineTextAlignment(.center)
            Spacer()
        }.frame(width: 150, height: 150)
    }
}
