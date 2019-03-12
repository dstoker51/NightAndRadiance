//
//  LightSource.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 3/5/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class LightSource: Strikeable, SceneObject {
    var worldPosition: Point
    
    init(worldPosition: Point, color: Color) {
        self.worldPosition = worldPosition
        super.init(material: Material(red: 1.0, green: 1.0, blue: 1.0))
    }
    
    override func hash(into hasher: inout Hasher) {
        hasher.combine(worldPosition)
        hasher.combine(super.material.color)
    }
}

func == (lhs: LightSource, rhs: LightSource) -> Bool {
    return lhs.worldPosition == rhs.worldPosition && lhs.material.color == rhs.material.color
}
