//
//  Sphere.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/10/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct Sphere: SceneObject {
    let radius: Double
    var worldPosition: Point
    
    init(radius: Double, worldPosition: Point) {
        self.radius = radius
        self.worldPosition = worldPosition
    }
    
    func intersect(ray: Ray) -> Bool {
        return false
    }
}
