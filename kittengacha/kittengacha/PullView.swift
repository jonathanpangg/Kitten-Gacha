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
        ScrollView{
        Button("Adopt") {
            test = cat.catPuller()
            pc = "\(cat.pullCount)"
        }
        .padding(.top)
        Spacer()
        Divider()
        ZStack(alignment: .leading){
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
