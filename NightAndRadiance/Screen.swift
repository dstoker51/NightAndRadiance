//
//  Screen.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 1/29/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct Screen: SceneObject {
    var width: Double = 0.0, height: Double = 0.0
    var screenU, screenV : Vector
    var worldPosition: Point
    var pixelWidth: Double
    var pixelHeight: Double
    var widthInPixels: UInt32
    var heightInPixels: UInt32
    var raster: Array<Array<Int>>
    
    init(screenU: Vector, screenV: Vector, worldPosition: Point, widthInPixels: UInt32, heightInPixels: UInt32) {
        self.screenU = screenU
        self.screenV = screenV
        self.worldPosition = worldPosition
        
        // Verify that screenU and screenV are orthogonal.
        if self.screenU.dot(self.screenV) != 0 {
            self.screenU = Vector(x: 0.0, y: 0.0, z: 0.0)
            self.screenV = Vector(x: 0.0, y: 1.0, z: 0.0)
            // Defaults will be used.
        }
        
        width = screenU.magnitude * 2.0
        height = screenV.magnitude * 2.0
        self.widthInPixels = widthInPixels
        self.heightInPixels = heightInPixels
        pixelWidth = width / Double(widthInPixels)
        pixelHeight = height / Double(heightInPixels)
        raster = Array(repeating: Array<Int>(repeating: 0, count: 3), count: Int(widthInPixels * heightInPixels))
    }
    
    func worldCoordinateFor(pixelU: UInt32, pixelV: UInt32) -> Point {
        if pixelU > widthInPixels || pixelV > heightInPixels {
            return Point(-1.0, -1.0, -1.0)
        }
        
        let uNDC = (Double(pixelU) + 0.5) / Double(widthInPixels) // 0 -> 1 (Normalized device coordinates)
        let vNDC = (Double(pixelV) + 0.5) / Double(heightInPixels) // 0 -> 1 (Normalized device coordinates)
        let uScreenCoords: Double = 2.0 * uNDC - 1    // -1 to 1 (left to right)
        let vScreenCoords: Double = 1 - 2.0 * vNDC    // -1 to 1 (top to bottom)
        // TODO Implement camera-to-world matrix. This only works in the standard coord system for now.
        return (screenU * uScreenCoords) + (screenV * vScreenCoords) + worldPosition
    }
    
    mutating func insertColorAtPixel(x: Int, y: Int, material: Material) {
        let index = y * Int(widthInPixels) + x
        raster[index][0] = material.color.red
        raster[index][1] = material.color.green
        raster[index][2] = material.color.blue
    }
}
