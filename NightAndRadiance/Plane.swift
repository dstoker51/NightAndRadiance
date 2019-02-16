//
//  Plane.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/10/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct Plane: SceneObject {
    let vectorU: Vector
    let vectorV: Vector
    var worldPosition: Point
    
    init(vectorU: Vector, vectorV: Vector, worldPosition: Point) {
        self.vectorU = vectorU
        self.vectorV = vectorV
        self.worldPosition = worldPosition
    }
    
    func intersect(ray: Ray) -> Bool {
        return false
    }
}
