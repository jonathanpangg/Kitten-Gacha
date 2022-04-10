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
      ScrollView {
          VStack(spacing: -1.0)
          {
            HStack(spacing: -1.0)
            {
              Tile()
                .border(Color.red, width: 1.00)
              Tile()
                .border(Color.red, width: 1.00)
            }
            HStack(spacing: -1.0)
            {
              Tile()
              .border(Color.red, width: 1.00)
              Tile()
                .border(Color.red, width: 1.00)
            }
            .padding(.bottom, 15)
          }
        }
      tabView(screenNumber)
      }
}
struct Tile : View
{
    var body: some View
    {
        VStack
        {
            Spacer()
            Text("Test")
            Spacer()
        }.frame(width: 150, height: 150)
    }
}

