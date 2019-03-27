//
//  Scene.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/8/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct Scene {
    typealias Eye = Point
    var screen: Screen
    let eye: Eye
    var lightSources = [LightSource]()
    var objectSet = Set<SceneObject>()
    
    init(screen: Screen, eye: Point) {
        self.screen = screen
        self.eye = eye
    }
    
    mutating func castRays() {
        for y in 0...screen.heightInPixels - 1 {
            for x in 0...screen.widthInPixels - 1 {
                let pixelLocation: Point = screen.worldCoordinateFor(pixelU: x, pixelV: y)
                let ray: Ray = Ray(emissionPoint: eye, directionVector: Vector(point1: eye, point2: pixelLocation))
                let cast = RayCast(initialRay: ray, objectSet: objectSet, lightSources: lightSources)
                screen.insertColorAtPixel(x: Int(x), y: Int(y), color: cast.trace(ray: cast.initialRay))
            }
        }
    }
}
