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
    var emissionPoint: Point3D
    var directionVector: Vector4D
    
    init(emissionPoint: Point3D, directionVector: Vector4D) {
        self.emissionPoint = emissionPoint
        self.directionVector = directionVector
    }
    
    func at(t: Double) -> Point3D {
        return emissionPoint + directionVector * t
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(emissionPoint)
        hasher.combine(directionVector)
    }
}

func == (lhs: Ray, rhs: Ray) -> Bool {
    return lhs.emissionPoint == rhs.emissionPoint && lhs.directionVector == rhs.directionVector
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

