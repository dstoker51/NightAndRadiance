//
//  Plane.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/10/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct Plane: SceneObject {
    let vectorU: Vector
    let vectorV: Vector
    let normal: Vector
    var worldPosition: Point
    var description: String { return "vectorU: \(vectorU), vectorV: \(vectorV), worldPosition: \(worldPosition)" }
    
    init(vectorU: Vector, vectorV: Vector, worldPosition: Point) {
        if vectorU.dot(vectorV) != 0 {
            self.vectorU = Vector(x: 0.0, y: 0.0, z: 0.0)
            self.vectorV = Vector(x: 0.0, y: 1.0, z: 0.0)
            self.normal = self.vectorU.cross(self.vectorV).normalized()
            self.worldPosition = worldPosition
        }
        else {
            self.vectorU = vectorU
            self.vectorV = vectorV
            self.normal = self.vectorU.cross(self.vectorV).normalized()
            self.worldPosition = worldPosition
        }
    }
    
    func isIntersectedBy(ray: Ray) -> (Bool, Array<Point>) {
        let dDotN = ray.directionVector.dot(normal)
        
        // Ray parallel to plane.
        if dDotN.isZero {
            return (false, [])
        }
        
        // Calculate intersection point.
        let root = (worldPosition - ray.emissionPoint).dot(normal) / dDotN
        let intersectionPoint = ray.emissionPoint + ray.directionVector * root
        
        // Infinite plane and ray not parallel. Guaranteed intersection.
        return (true, [intersectionPoint])
    }
}
