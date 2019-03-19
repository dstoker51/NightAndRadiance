//
//  Plane.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/10/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Plane: SceneObject {
    let vectorU: Vector
    let vectorV: Vector
    let normal: Vector
    var description: String { return "vectorU: \(vectorU), vectorV: \(vectorV), worldPosition: \(worldPosition)" }
    
    init(vectorU: Vector, vectorV: Vector, worldPosition: Point, material: Material) {
        if vectorU.dot(vectorV) != 0 {
            self.vectorU = Vector(x: 0.0, y: 0.0, z: 0.0)
            self.vectorV = Vector(x: 0.0, y: 1.0, z: 0.0)
        }
        else {
            self.vectorU = vectorU
            self.vectorV = vectorV
        }
        self.normal = self.vectorU.cross(self.vectorV).normalized()
        super.init(worldPosition: worldPosition, material: material)
    }
    
    override func hash(into hasher: inout Hasher) {
        hasher.combine(vectorU)
        hasher.combine(vectorV)
        hasher.combine(material)
    }
    
    override func calculateIntersectionPointsWith(ray: Ray) -> Array<Point> {
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
    
    override func calculateRootsWith(ray: Ray) -> Array<Double> {
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
    
    override func calculateNormalAt(point: Point) -> Vector {
        return normal
    }
}

func ==(rhs: Plane, lhs: Plane) -> Bool {
    return rhs.vectorU == lhs.vectorU && rhs.vectorV == lhs.vectorV && rhs.material == lhs.material
}
