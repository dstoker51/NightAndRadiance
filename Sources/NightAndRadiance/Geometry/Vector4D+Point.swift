//
//  Vector+Point3D.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/24/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

// MARK: - Vector operations that operate on or result in Points.
extension Vector4D {
    init(point1: Point3D, point2: Point3D) {
        self.init(x: point2.x - point1.x, y: point2.y - point1.y, z: point2.z - point1.z)
    }
    
    static func +(vector: Vector4D, point: Point3D) -> Point3D {
        return Point3D(point.x + vector.x, point.y + vector.y, point.z + vector.z)
    }
    
    static func -(vector: Vector4D, point: Point3D) -> Point3D {
        return Point3D(point.x - vector.x, point.y - vector.y, point.z - vector.z)
    }
}

// MARK: - Point3D operations that operate on or result in Vectors.
extension Point3D {
    static func +(point: Point3D, vector: Vector4D) -> Point3D {
        return Point3D(point.x + vector.x, point.y + vector.y, point.z + vector.z)
    }
    
    static func -(point: Point3D, vector: Vector4D) -> Point3D {
        return Point3D(point.x - vector.x, point.y - vector.y, point.z - vector.z)
    }
    
    static func -(lhs: Point3D, rhs: Point3D) -> Vector4D {
        return Vector4D(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
}
