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
                Text("\(screenNumber.userStats.collection[i])")
            }
        }
        Button("Pull") {
            screenNumber.screenNumber = 0
        }
    }
}
