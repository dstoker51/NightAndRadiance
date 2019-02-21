//
//  SceneObjects.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/8/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

protocol SceneObject: Hashable {
    var worldPosition: Point { get set }
    func getIntersectionPointsWith(ray: Ray) -> Array<Point>
    func getRootsWith(ray: Ray) -> Array<Double>
    
//    static func == (rhs: SceneObject, lhs: SceneObject) -> Bool {
////        if rhs.worldPositionX == lhs.worldPositionX &&
////            rhs.worldPositionY == lhs.worldPositionY &&
////            rhs.worldPositionZ == lhs.worldPositionZ {
////            return true
////        }
//        return (rhs === lhs ? true : false)
//    }
}

