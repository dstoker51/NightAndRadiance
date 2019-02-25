//
//  Color.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/23/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

/// Contains all properties required to define the physical aspects of a ray-traceable object.
/// This includes color, reflective properties, refractive properties, etc.
struct Material {
    let red: Int
    let green: Int
    let blue: Int
//    let refractionIndex: Double
    
    init(red: Int, blue: Int, green: Int) {
        self.red = red
        self.blue = blue
        self.green = green
        
    }
}
