//
//  ContentView.swift
//  kittengacha
//
//  Created by Jonathan Pang on 4/9/22.
//
 
import SwiftUI

struct ContentView: View {
    @ObservedObject var screenNumber = Screens()

    var body: some View {
        switch (screenNumber.screenNumber) {
            case 0:
                PullView(screenNumber: screenNumber)
            default:
                CollectionView(screenNumber: screenNumber)
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
