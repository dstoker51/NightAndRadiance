//
//  Point.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 1/27/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Point {
    var x, y, z: Double
    
    init?(_ x: Double, _ y: Double, _ z: Double) {
        guard !x.isNaN && !y.isNaN && !z.isNaN else {
            return nil
        }
        self.x = x
        self.y = y
        self.z = z
    }
}

func +(point: Point, vector: Vector) -> Point {
    // FIXME Forcing this unwrap is dangerous. But this operation expects this to just work, right?
    return Point(point.x + vector.x, point.y + vector.y, point.z + vector.z)!
}

func -(point: Point, vector: Vector) -> Point {
    // FIXME Forcing this unwrap is dangerous. But this operation expects this to just work, right?
    return Point(point.x - vector.x, point.y - vector.y, point.z - vector.z)!
}
