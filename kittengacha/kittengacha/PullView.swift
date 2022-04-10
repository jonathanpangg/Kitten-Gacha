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
    @ObservedObject var variables = Variables()
    @State var bg: String = ""
    var cat = Cats()
    @ObservedObject var screenNumber: Screens
    @State var list = [String]()
    
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
                    variables.pc = "\(cat.pullCount)"
                    list.append(test)
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
                .scaledToFit()
                .clipped()
                .listRowInsets(EdgeInsets())
                Image(test)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, minHeight: 15)
                    .padding(30)
                    .cornerRadius(10)

            }
            .offset(y: UIScreen.main.bounds.height / -64)
            
            Divider()
            VStack() {
                Text(test)
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                        

                Divider()

                Text("Current Pity: \n" + String(variables.pc))
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 15)
            }
            .padding()
        }
        ZStack {
            Image("clouds")
                .resizable()
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 16)
            HStack(alignment: .center) {
                Button("Run") {
                    screenNumber.screenNumber = 3
                    screenNumber.userStats.collection += list
                }
                .padding(.leading, UIScreen.main.bounds.width / 8)
                Spacer()
                Button("Pull") {
                    screenNumber.screenNumber = 0
                    screenNumber.userStats.collection += list
                }
                .padding(.leading, UIScreen.main.bounds.width / 20)
                Spacer()
                Button("Collection") {
                    screenNumber.screenNumber = 1
                    screenNumber.userStats.collection += list
                }
                .padding(.trailing, UIScreen.main.bounds.width / 16)
            }
        }
        .offset(y: UIScreen.main.bounds.height / 96)
        .foregroundColor(Color.black)
    }
}
