//
//  UserStats.swift
//  kittengacha
//
//  Created by Jonathan Pang on 4/9/22.
//

import Foundation

struct UserStats: Codable {
    var steps: Double = 0
    var prevLogin: Date = Date()
    var currLogin: Date = Date()
    var collection: [String] = []
}
