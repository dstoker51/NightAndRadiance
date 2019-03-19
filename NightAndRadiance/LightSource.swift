//
//  LightSource.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 3/5/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class LightSource: SceneObject {
    init(worldPosition: Point, color: Color) {
        super.init(worldPosition: worldPosition, material: Material(red: 1.0, green: 1.0, blue: 1.0))
    }
    
    override func hash(into hasher: inout Hasher) {
        hasher.combine(worldPosition)
        hasher.combine(material)
    }
}

func == (lhs: LightSource, rhs: LightSource) -> Bool {
    return lhs.worldPosition == rhs.worldPosition && lhs.material == rhs.material
}
