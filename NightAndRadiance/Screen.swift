//
//  Screen.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 1/29/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Screen {
    var width: UInt32 = 0, height: UInt32 = 0
    var centerX: Double = -1.0, centerY: Double = -1.0
    var screenU, screenV : Vector
    
    init(screenWidth: Int, screenHeight: Int, screenU: Vector, screenV: Vector) {
        self.screenU = screenU.normalized()
        self.screenV = screenV.normalized()
        
        // Verify that screenU and screenV are orthogonal.
        if self.screenU.dot(self.screenV) != 0 {
            self.screenU = Vector(x: 0.0, y: 0.0, z: 0.0)
            self.screenV = Vector(x: 0.0, y: 0.0, z: 0.0)
            // Defaults will be used.
        }
        else {
            width = UInt32(abs(screenWidth))
            height = UInt32(abs(screenHeight))
            centerX = Double(width) / 2.0
            centerY = Double(height) / 2.0
        }
    }
}
