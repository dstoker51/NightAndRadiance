//
//  Point.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 1/27/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

/// A 3D point. 
struct Point: Hashable, CustomStringConvertible {
    var x, y, z: Double
    var description: String { return "(x: \(x), y: \(y), z: \(z))" }
    
    init(_ x: Double, _ y: Double, _ z: Double) {
        if x.isNaN || y.isNaN || z.isNaN {
            self.x = Double.infinity
            self.y = Double.infinity
            self.z = Double.infinity
        }
        else {
            self.x = x
            self.y = y
            self.z = z
        }
    }
}

func == (lhs: Point, rhs: Point) -> Bool {
    return (lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z ? true : false)
}
