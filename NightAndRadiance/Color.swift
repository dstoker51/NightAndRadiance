//
//  Color.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 3/1/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct Color: Hashable {
    let red:   Int
    let green: Int
    let blue:  Int
    static let min = 0.0
    static let max = 255.0
    
    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}
