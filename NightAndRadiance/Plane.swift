//
//  Plane.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/10/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Plane: SceneObject {
    let vectorU: Vector
    let vectorV: Vector
    
    init(vectorU: Vector, vectorV: Vector, worldPosition: Point) {
        self.vectorU = vectorU
        self.vectorV = vectorV
        
        super.init(worldPosition: worldPosition)
    }
    
    override func intersect(ray: Ray) -> Bool {
        return false
    }
    
    override func hash(into hasher: inout Hasher) {
        // TODO How to use super's hash function instead of combining all by hand?
        //        super.hash(into: hasher)
        hasher.combine(super.worldPosition)
        hasher.combine(vectorU)
        hasher.combine(vectorV)
    }
}
