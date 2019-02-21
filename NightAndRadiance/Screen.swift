//
//  Screen.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 1/29/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct Screen {
    var width: Double = 0.0, height: Double = 0.0
    var screenCenter = Point(0.0, 0.0, 0.0)
    var screenU, screenV : Vector
    var worldPosition: Point
    var pixelWidth: Double
    var pixelHeight: Double
    
    init(screenU: Vector, screenV: Vector, worldPosition: Point, numberOfPixelsWide: UInt32, numberOfPixelsTall: UInt32) {
        self.screenU = screenU
        self.screenV = screenV
        self.worldPosition = worldPosition
        
        // Verify that screenU and screenV are orthogonal.
        if self.screenU.dot(self.screenV) != 0 {
            self.screenU = Vector(x: 0.0, y: 0.0, z: 0.0)
            self.screenV = Vector(x: 0.0, y: 1.0, z: 0.0)
            // Defaults will be used.
        }
        
        width = screenU.magnitude
        height = screenV.magnitude
        screenCenter = Point(Double(width) / 2.0, Double(height) / 2.0, 0.0)
        pixelWidth = width / Double(numberOfPixelsWide)
        pixelHeight = height / Double(numberOfPixelsTall)
    }
    
    
}
