//
//  Triangle.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 3/13/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Triangle: SceneObject, CustomStringConvertible {
    var a: Point
    var b: Point
    var c: Point
    var normal: Vector
    var description: String {return "Triangle(\(a), \(b), \(c)), worldPosition: \(worldPosition)"}
    
    init(material: Material, a: Point, b: Point, c: Point) {
        self.a = a
        self.b = b
        self.c = c
        
        // Calculate normal.
        let vectorOne = Vector(point1: a, point2: b)
        let vectorTwo = Vector(point1: b, point2: c)
        self.normal = vectorOne.cross(vectorTwo).normalized()
        
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
        preconditionFailure("This method must be overridden.")
    }
    override func calculateRootsWith(ray: Ray) -> Array<Double> {
        // Moller Trumbore algorithm
        // https://www.scratchapixel.com/lessons/3d-basic-rendering/ray-tracing-rendering-a-triangle/moller-trumbore-ray-triangle-intersection
        let v0v1 = b - a
        let v0v2 = c - a
        let pVec = ray.directionVector.cross(v0v2)
        let det = v0v1.dot(pVec)
        
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
        
        
    }
    override func calculateNormalAt(point: Point) -> Vector {
        return normal
    }
}
