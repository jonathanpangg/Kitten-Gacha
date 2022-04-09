//
//  Cats.swift
//  Kitten Gacha (iOS)
//
//  Created by Jason Kwan on 4/9/22.
//

import Foundation

class Cats {
    //Represents the % chance of pulling 3,4,5,6 star cats
    let threeStar = 0.8299
    let fourStar = 0.15
    let fiveStar = 0.02
    let sixStar = 0.01
    var pullCount = 0
    let hardPity = 100

    //The actual cats for rarity
    var threeStarList = ["food", "water"]
    var fourStarList = ["grey cat", "orange cat", "black cat"]
    var fiveStarList = ["Rocco", "Sam"]
    var sixStarList = ["hairless cat"]

            
    //pulls a cat for a user
    func catPuller() -> String {
        let random = Double.random(in: 0 ... 1)
        var r : Int
        if (pullCount >= hardPity) {
            pullCount = 0
            r = Int.random(in:0 ... (fiveStarList.count - 1))
            return fiveStarList[r]
        }
        else if (random < threeStar) {
            pullCount += 1
            r = Int.random(in:0 ... (threeStarList.count - 1))
            return threeStarList[r]
        }
        else if (random >= threeStar && (random < (threeStar + fourStar))) {
            pullCount += 1
            r = Int.random(in:0 ... (fourStarList.count - 1))
            return fourStarList[r]
        }
        else if(random >= (threeStar + fourStar) && (random < (threeStar + fourStar + fiveStar))) {
            r = Int.random(in:0 ... (fiveStarList.count - 1))
            pullCount = 0
            return fiveStarList[r]
        }
        r = Int.random(in: 0 ... (sixStarList.count - 1))
        return sixStarList[r]
    }
}
