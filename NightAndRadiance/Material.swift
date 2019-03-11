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
struct Material: Hashable {
    let color: Color
//    let refractionIndex: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.color = Color(red: red, green: green, blue: blue)
    }
    
    init(red: Int, green: Int, blue: Int) {
        self.color = Color(red: red, green: green, blue: blue)
    }
    
    init(material: Material) {
        self.init(red: material.color.red, green: material.color.green, blue: material.color.blue)
    }
}
