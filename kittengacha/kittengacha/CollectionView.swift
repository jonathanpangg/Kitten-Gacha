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
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach(0..<screenNumber.userStats.collection.count) { i in
                if (screenNumber.userStats.collection[i] == "black cat") {
                    Image("black cat")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                } else if (screenNumber.userStats.collection[i] == "food") {
                    Image("food")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                } else if (screenNumber.userStats.collection[i] == "grey cat") {
                    Image("grey cat")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                }
                else if (screenNumber.userStats.collection[i] == "hairless cat") {
                    Image("hairless cat")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                } else if (screenNumber.userStats.collection[i] == "orange cat") {
                    Image("orange cat ")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                } else if (screenNumber.userStats.collection[i] == "Rocco") {
                    Image("Rocco")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                } else {
                    Image("water")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 400)
                        .clipped()
                        .listRowInsets(EdgeInsets())
                }
                
            }
        }
        Button("Pull") {
            screenNumber.screenNumber = 0
        }
    }
}
