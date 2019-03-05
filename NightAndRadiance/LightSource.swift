//
//  LightSource.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 3/5/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct LightSource: SceneObject {
    var worldPosition: Point
    let color: Color
    
    init(worldPosition: Point, color: Color) {
        self.worldPosition = worldPosition
        self.color = color
    }
}
