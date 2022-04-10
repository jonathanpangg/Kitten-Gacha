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
        /*
        switch (screenNumber.screenNumber) {
            case 1:
                CollectionView(screenNumber: screenNumber)
            case 2:
                PullConversionView(screenNumber: screenNumber)
            default:
                PullView(screenNumber: screenNumber)
                
        }
        */
        RunView(screenNumber: screenNumber)
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
