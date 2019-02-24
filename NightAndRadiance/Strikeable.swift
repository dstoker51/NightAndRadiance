//
//  Strikeable.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/24/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

protocol Strikeable {
    func calculateIntersectionPointsWith(ray: Ray) -> Array<Point>
    func calculateRootsWith(ray: Ray) -> Array<Double>
    func calculateNormalAt(point: Point) -> Vector
}
