//
//  PullConversionView.swift
//  kittengacha
//
//  Created by Jason Kwan on 4/9/22.
//

import Foundation
import SwiftUI
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create image
        let image = UIImage(named: "button.png")
        
        let button = UIButton()
        button.frame = CGRect(x: 10, y: 100, width: 100, height: 100)
        button.setBackgroundImage(image, for: UIControl.State.normal)
        button.addTarget(self, action:#selector(self.imageButtonTapped(_:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        
    }
    
    @objc func imageButtonTapped(_ sender:UIButton!)
    {
        print("My image button tapped")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

struct PullConversionView: View {
    var totalSteps = 0
    
    @State var test: String = ""
    @State var pc: String = ""
    var cat = Cats()
    @ObservedObject var screenNumber: Screens
    
    var body: some View {
        VStack {
            Button(action: {
            }, label: {
                
                ZStack {
                    Image("button")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 15)
                    Text("Convert Steps")
                        .foregroundColor(.red)
                }
            })
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
