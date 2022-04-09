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
    }
}
