//
//  Point.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 1/27/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Point: Hashable {
    var x, y, z: Double
    
    init(_ x: Double, _ y: Double, _ z: Double) {
        if x.isNaN || y.isNaN || z.isNaN {
            self.x = 0.0
            self.y = 0.0
            self.z = 0.0
        }
        else {
            self.x = x
            self.y = y
            self.z = z
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }
}

func +(point: Point, vector: Vector) -> Point {
    return Point(point.x + vector.x, point.y + vector.y, point.z + vector.z)
}

func -(point: Point, vector: Vector) -> Point {
    return Point(point.x - vector.x, point.y - vector.y, point.z - vector.z)
}

func == (lhs: Point, rhs: Point) -> Bool {
    return (lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z ? true : false)
}
