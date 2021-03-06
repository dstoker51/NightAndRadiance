//
//  Triangle.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 3/13/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Triangle: SceneObject, CustomStringConvertible {
    let a: Point
    let b: Point
    let c: Point
    let vectorAB: Vector
    let vectorAC: Vector
    let normal: Vector
    var description: String {return "Triangle(\(a), \(b), \(c)), worldPosition: \(worldPosition)"}
    
    init(material: Material, a: Point, b: Point, c: Point) {
        self.a = a
        self.b = b
        self.c = c
        
        // Calculate normal.
        vectorAB = Vector(point1: a, point2: b)
        vectorAC = Vector(point1: a, point2: c)
        self.normal = vectorAB.cross(vectorAC).normalized()
        
        // Calculate centroid of triangle from input points.
        let centroidX = (a.x + b.x + c.x) / 3.0
        let centroidY = (a.y + b.y + c.y) / 3.0
        let centroidZ = (a.z + b.z + c.z) / 3.0
        
        // Create super class object.
        super.init(worldPosition: Point(centroidX, centroidY, centroidZ), material: material)
    }
    
    override func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(material)
        hasher.combine(a)
        hasher.combine(b)
        hasher.combine(c)
    }
    
    override func calculateIntersectionPointsWith(ray: Ray) -> Array<Point> {
        let roots = calculateRootsWith(ray: ray)
        
        // Triangles can only have one intersection point.
        if roots.count > 0 {
            return [ray.emissionPoint + ray.directionVector * roots[0]]
        }
        else {
            return []
        }
    }
    override func calculateRootsWith(ray: Ray) -> Array<Double> {
        // Moller Trumbore algorithm
        // https://www.scratchapixel.com/lessons/3d-basic-rendering/ray-tracing-rendering-a-triangle/moller-trumbore-ray-triangle-intersection
        let pVec = ray.directionVector.cross(vectorAC)
        let det = vectorAB.dot(pVec)
        
        // Culling of backwards-facing triangles
        let shouldCull = true
        if (shouldCull) {
            if (det.isZero) {
                return []
            }
        }
        
        // Ray and triangle are parallel if determinant is close to zero.
        if (abs(det).isZero) {
            return []
        }
        
        let invDet = 1.0 / det
        let tVec = ray.emissionPoint - a
        let u = tVec.dot(pVec) * invDet
        if (u < 0.0 || u > 1.0) {
            return []
        }
        
        let qVec = tVec.cross(vectorAB)
        let v = ray.directionVector.dot(qVec) * invDet
        if(v < 0.0 || u + v > 1.0) {
            return []
        }
        
        return [vectorAC.dot(qVec) * invDet]
        
    }
    override func calculateNormalAt(point: Point) -> Vector {
        return normal
    }
}
