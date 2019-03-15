//
//  Vector+Point.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/24/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

// MARK: - Vector operations that operate on or result in Points.
extension Vector {
    init(point1: Point, point2: Point) {
        self.init(x: point2.x - point1.x, y: point2.y - point1.y, z: point2.z - point1.z)
    }
    
    static func +(vector: Vector, point: Point) -> Point {
        return Point(point.x + vector.x, point.y + vector.y, point.z + vector.z)
    }
    
    static func -(vector: Vector, point: Point) -> Point {
        return Point(point.x - vector.x, point.y - vector.y, point.z - vector.z)
    }
}

// MARK: - Point operations that operate on or result in Vectors. 
extension Point {
    static func +(point: Point, vector: Vector) -> Point {
        return Point(point.x + vector.x, point.y + vector.y, point.z + vector.z)
    }
    
    static func -(point: Point, vector: Vector) -> Point {
        return Point(point.x - vector.x, point.y - vector.y, point.z - vector.z)
    }
    
    static func -(lhs: Point, rhs: Point) -> Vector {
        return Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
}
