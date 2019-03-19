//
//  Strikeable.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/24/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

// Swift doesn't have generalized existentials. See https://github.com/apple/swift/blob/master/docs/GenericsManifesto.md#generalized-existentials
// Because of that, this is going to be an abstract class. And since those don't exist in Swift, it is going to be a base class that can't
// be initialized on its own.
class SceneObject: Hashable {
    let identifier = UUID()
    var worldPosition: Point
    var material: Material
    
    init(worldPosition: Point, material: Material) {
        self.worldPosition = worldPosition
        self.material = material
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(material)
    }
    
    func calculateIntersectionPointsWith(ray: Ray) -> Array<Point> {
        preconditionFailure("This method must be overridden.")
    }
    func calculateRootsWith(ray: Ray) -> Array<Double> {
        preconditionFailure("This method must be overridden.")
    }
    func calculateNormalAt(point: Point) -> Vector {
        preconditionFailure("This method must be overridden.")
    }
}

func ==(lhs: SceneObject, rhs: SceneObject) -> Bool {
    return false
}
