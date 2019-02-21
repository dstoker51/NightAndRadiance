//
//  Sphere.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/10/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct Sphere: SceneObject, CustomStringConvertible {
    let radius: Double
    var worldPosition: Point
    var description: String { return "radius: \(radius), worldPosition: \(worldPosition)" }
    
    init(radius: Double, worldPosition: Point) {
        self.radius = radius
        self.worldPosition = worldPosition
    }
    
    func isIntersectedBy(ray: Ray) -> Array<Point> {
        let eMinusO = ray.emissionPoint - worldPosition
        let a = ray.directionVector.dot(ray.directionVector)
        let b = (ray.directionVector * 2.0).dot(eMinusO)
        let c = (eMinusO).dot(eMinusO) - radius * radius
        let h = (b * b) - (4.0 * a * c)
        
        if h < 0 {  // Ray misses sphere.
            return []
        }
        else if h == 0 { // Ray is tangent to sphere.
            let point = ray.emissionPoint + ray.directionVector * (-b / (2.0 * a))
            return [point]
        }
        else {  // Ray intersects sphere 2X. h > 0
            let denominatorFraction = 1.0 / (2.0 * a)
            let firstRoot = (-b + sqrt(h)) * denominatorFraction
            let secondRoot = (-b - sqrt(h)) * denominatorFraction
            let firstIntersectionPoint = ray.emissionPoint + ray.directionVector * firstRoot
            let secondIntersectionPoint = ray.emissionPoint + ray.directionVector * secondRoot
            return [firstIntersectionPoint, secondIntersectionPoint]
        }
    }
    
    
}
