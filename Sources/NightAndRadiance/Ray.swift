//
//  Ray.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 1/28/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

/// A structure made up of an emission point and a direction vector. Used for ray tracing.
struct Ray: Equatable {
    var emissionPoint: Point
    var directionVector: Vector
    
    init(emissionPoint: Point, directionVector: Vector) {
        self.emissionPoint = emissionPoint
        self.directionVector = directionVector
    }
    
    func at(t: Double) -> Point {
        return emissionPoint + directionVector * t
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(emissionPoint)
        hasher.combine(directionVector)
    }
}

func * (ray: Ray, scalar: Double) -> Ray {
    guard !scalar.isNaN && scalar.isFinite else {
        return ray
    }
    return Ray(emissionPoint: ray.emissionPoint, directionVector: ray.directionVector * scalar)
}

func *= (ray: inout Ray, scalar: Double) {
    guard !scalar.isNaN && scalar.isFinite else {
        return
    }
    ray.directionVector = ray.directionVector * scalar
}

