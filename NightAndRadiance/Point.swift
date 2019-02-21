//
//  Point.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 1/27/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

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

func +(point: Point, vector: Vector) -> Point {
    return Point(point.x + vector.x, point.y + vector.y, point.z + vector.z)
}

func -(point: Point, vector: Vector) -> Point {
    return Point(point.x - vector.x, point.y - vector.y, point.z - vector.z)
}

func -(lhs: Point, rhs: Point) -> Vector {
    return Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
}

func == (lhs: Point, rhs: Point) -> Bool {
    return (lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z ? true : false)
}
