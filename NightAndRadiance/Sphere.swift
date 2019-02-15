//
//  Sphere.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/10/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Sphere: SceneObject {
    let radius: Double
    
    init(radius: Double, worldPosition: Point) {
        self.radius = radius
        super.init(worldPosition: worldPosition)
    }
    
    override func intersect(ray: Ray) -> Bool {
        return false
    }
    
    override func hash(into hasher: inout Hasher) {
        // TODO How to use super's hash function instead of combining all by hand?
        //        super.hash(into: hasher)
        hasher.combine(super.worldPosition)
        hasher.combine(radius)
    }
}
