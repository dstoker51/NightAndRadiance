//
//  Sphere.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/10/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct Sphere: SceneObject, Strikeable, CustomStringConvertible {
    let radius: Double
    var material: Material
    var worldPosition: Point
    var description: String { return "radius: \(radius), worldPosition: \(worldPosition)" }
    
    init(radius: Double, worldPosition: Point, material: Material) {
        self.radius = radius
        self.worldPosition = worldPosition
        self.material = material
    }
    
    func calculateIntersectionPointsWith(ray: Ray) -> Array<Point> {
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
    
    func calculateRootsWith(ray: Ray) -> Array<Double> {
        let eMinusO = ray.emissionPoint - worldPosition
        let a = ray.directionVector.dot(ray.directionVector)
        let b = (ray.directionVector * 2.0).dot(eMinusO)
        let c = (eMinusO).dot(eMinusO) - radius * radius
        let h = (b * b) - (4.0 * a * c)
        
        if h < 0 {  // Ray misses sphere.
            return []
        }
        else if h == 0 { // Ray is tangent to sphere.
            return [-b / (2.0 * a)]
        }
        else {  // Ray intersects sphere 2X. h > 0
            let denominatorFraction = 1.0 / (2.0 * a)
            let firstRoot = (-b + sqrt(h)) * denominatorFraction
            let secondRoot = (-b - sqrt(h)) * denominatorFraction
            return [firstRoot, secondRoot]
        }
    }
    
    func calculateNormalAt(point: Point) -> Vector {
        return (point - worldPosition).normalized()
    }
}
