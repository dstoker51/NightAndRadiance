//
//  Plane.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/10/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct Plane: SceneObject, Strikeable {
    let vectorU: Vector
    let vectorV: Vector
    let normal: Vector
    var red, green, blue: UInt8
    var worldPosition: Point
    var description: String { return "vectorU: \(vectorU), vectorV: \(vectorV), worldPosition: \(worldPosition)" }
    
    init(vectorU: Vector, vectorV: Vector, worldPosition: Point, red: UInt8, green: UInt8, blue: UInt8) {
        if vectorU.dot(vectorV) != 0 {
            self.vectorU = Vector(x: 0.0, y: 0.0, z: 0.0)
            self.vectorV = Vector(x: 0.0, y: 1.0, z: 0.0)
        }
        else {
            self.vectorU = vectorU
            self.vectorV = vectorV
        }
        self.normal = self.vectorU.cross(self.vectorV).normalized()
        self.worldPosition = worldPosition
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    func calculateIntersectionPointsWith(ray: Ray) -> Array<Point> {
        let dDotN = ray.directionVector.dot(normal)
        
        // Ray parallel to plane.
        if dDotN.isZero {
            return []
        }
        
        // Calculate intersection point.
        let root = (worldPosition - ray.emissionPoint).dot(normal) / dDotN
        let intersectionPoint = ray.emissionPoint + ray.directionVector * root
        
        // Infinite plane and ray not parallel. Guaranteed intersection.
        return [intersectionPoint]
    }
    
    func calculateRootsWith(ray: Ray) -> Array<Double> {
        let dDotN = ray.directionVector.dot(normal)
        
        // Ray parallel to plane.
        if dDotN.isZero {
            return []
        }
        
        // Infinite plane and ray not parallel. Guaranteed intersection.
        // Calculate the root.
        let root = (worldPosition - ray.emissionPoint).dot(normal) / dDotN
        return [root]
    }
    
    func calculateNormalAt(point: Point) -> Vector {
        if (point - worldPosition).dot(normal) == 0 {   // Make sure the point lies on the plane.
            return normal
        }
        return Vector(x: 0.0, y: 0.0, z: 0.0)
    }
}
