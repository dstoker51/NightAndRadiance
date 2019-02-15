//
//  Ray.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 1/28/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Ray: Hashable {
    let emissionPoint: Point
    let directionVector: Vector
    
    init(emissionPoint: Point, directionVector: Vector) {
        self.emissionPoint = emissionPoint
        self.directionVector = directionVector
    }
    
    convenience init(originX: Double, originY: Double, originZ: Double, vectorX: Double, vectorY: Double, vectorZ: Double) {
        self.init(emissionPoint: Point(originX, originY, originZ), directionVector: Vector(x: vectorX, y: vectorY, z: vectorZ))
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(emissionPoint)
        hasher.combine(directionVector)
    }
}

func == (lhs: Ray, rhs: Ray) -> Bool {
    return (lhs.emissionPoint == rhs.emissionPoint && lhs.directionVector == rhs.directionVector ? true : false)
}

