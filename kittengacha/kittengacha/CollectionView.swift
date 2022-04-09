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
        Text("Something")
        Button("Pull") {
            screenNumber.screenNumber = 0
        }
    }
}
