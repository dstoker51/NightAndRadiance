//
//  Screen.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 1/29/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Screen {
    var width: Int = -1, height: Int = -1
    var centerX: Double = -1.0, centerY: Double = -1.0
    var screenU, screenV : Vector?
    
    init?(screenWidth: Int, screenHeight: Int, screenU: Vector?, screenV: Vector?) {
        if let u = screenU, let v = screenV {
            self.screenU = u.normalized()
            self.screenV = v.normalized()
            
            // Verify that screenU and screenV are orthogonal.
            if self.screenU?.dot(self.screenV!) != 0 {
                return nil
            }
            
            // If all is well then continue to initialize the screen.
            width = screenWidth
            height = screenHeight
            centerX = Double(width) / 2.0
            centerY = Double(height) / 2.0
        }
    }
}
