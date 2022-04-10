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
    VStack(spacing: -1.0)
    {
      HStack(spacing: -1.0)
      {
        Tile()
          .border(Color.red, width: 0.90)
        Tile()
          .border(Color.red, width: 0.90)
      }
      HStack(spacing: -1.0)
      {
        Tile()
        .border(Color.red, width: 0.90)
        Tile()
          .border(Color.red, width: 0.90)
      }
      .padding(.bottom, 15)
    }
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

