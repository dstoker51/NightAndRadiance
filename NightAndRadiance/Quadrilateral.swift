//
//  Rectangle.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 3/13/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation


/// A definition for a convex quadrilateral.
class Quadrilateral: Plane {
    override init(vectorU: Vector, vectorV: Vector, worldPosition: Point, material: Material) {
        super.init(vectorU: vectorU, vectorV: vectorV, worldPosition: worldPosition, material: material)
    }
    
}
