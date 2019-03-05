//
//  Ray.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 1/28/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

/// A structure made up of an emission point and a direction vector. Used for ray tracing.
struct Ray: Hashable {
    let emissionPoint: Point
    let directionVector: Vector
    
    init(emissionPoint: Point, directionVector: Vector) {
        self.emissionPoint = emissionPoint
        self.directionVector = directionVector
    }
    
    func pointFrom(t: Double) -> Point {
        return emissionPoint + directionVector * t
    }
}

func == (lhs: Ray, rhs: Ray) -> Bool {
    return (lhs.emissionPoint == rhs.emissionPoint && lhs.directionVector == rhs.directionVector ? true : false)
}

func * (ray: Ray, scalar: Double) -> Ray {
    if scalar.isNaN { return ray }
    return Ray(emissionPoint: ray.emissionPoint, directionVector: ray.directionVector * scalar)
}

