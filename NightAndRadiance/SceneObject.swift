//
//  SceneObjects.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/8/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class SceneObject: Hashable {
    let worldPosition: Point
    
    init(worldPosition: Point) {
        self.worldPosition = worldPosition
    }
    
    func intersect(ray: Ray) -> Bool {
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(worldPosition)
    }
    
    static func == (rhs: SceneObject, lhs: SceneObject) -> Bool {
//        if rhs.worldPositionX == lhs.worldPositionX &&
//            rhs.worldPositionY == lhs.worldPositionY &&
//            rhs.worldPositionZ == lhs.worldPositionZ {
//            return true
//        }
        return (rhs === lhs ? true : false)
    }
}
