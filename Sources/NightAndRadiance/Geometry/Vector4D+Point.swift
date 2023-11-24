////
////  Vector+Point.swift
////  NightAndRadiance
////
////  Created by Darin Stoker on 2/24/19.
////  Copyright © 2019 Darin Stoker. All rights reserved.
////
//
//import Foundation
//
//// MARK: - Vector operations that operate on or result in Points.
//extension Vector4D {
//    init(point1: Point, point2: Point) {
//        self.init(x: point2.x - point1.x, y: point2.y - point1.y, z: point2.z - point1.z)
//    }
//    
//    init(point: Point) {
//        self.init(point1: Point(0.0, 0.0, 0.0), point2: point)
//    }
//    
//    static func +(vector: Vector4D, point: Point) -> Vector4D {
//        return Vector4D(x: point.x + vector.x, y: point.y + vector.y, z: point.z + vector.z)
//    }
//    
//    static func -(vector: Vector4D, point: Point) -> Vector4D {
//        return Vector4D(x: vector.x - point.x, y: vector.y - point.y, z: vector.z - point.z)
//    }
//}
//
//// MARK: - Point operations that operate on or result in Vectors.
//extension Point {
//    init(vector: Vector4D) {
//        self.init(vector.x, vector.y, vector.z)
//    }
//
//    static func +(point: Point, vector: Vector4D) -> Point {
//        return Point(point.x + vector.x, point.y + vector.y, point.z + vector.z)
//    }
//
//    static func +(lhs: Point, rhs: Point) -> Vector4D {
//        return Vector4D(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
//    }
//    
//    static func -(point: Point, vector: Vector4D) -> Point {
//        return Point(point.x - vector.x, point.y - vector.y, point.z - vector.z)
//    }
//    
//    static func -(lhs: Point, rhs: Point) -> Vector4D {
//        return Vector4D(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
//    }
//}
