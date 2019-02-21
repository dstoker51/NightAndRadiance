//
//  Scene.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/8/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Scene {
    typealias Eye = Point
    let screen: Screen
    let eye: Eye
//    var objectSet: Set<SceneObject> // Swift does yet have generalized existentials (see https://github.com/apple/swift/blob/master/docs/GenericsManifesto.md#generalized-existentials)
    
    // TODO Figure out the piece from above. Better than separate sets.
    var sphereSet: Set<Sphere>
    var planeSet: Set<Plane>
    
    init(screen: Screen, screenU: Vector, screenV: Vector, eye: Point, sphereSet: Set<Sphere>, planeSet: Set<Plane>) {
        self.screen = screen
        self.eye = eye
        self.sphereSet = sphereSet
        self.planeSet = planeSet
    }
    
    func trace() {
        for x in 0...screen.numberOfPixelsWide - 1 {
            for y in 0...screen.numberOfPixelsTall - 1 {
                let pixelLocation: Point = screen.worldCoordinateFor(pixelX: x, pixelY: y)
                let ray: Ray = Ray(emissionPoint: eye, directionVector: Vector(point1: eye, point2: pixelLocation))
                var spheresIntersected = Array<(Array<Point>, Sphere)>()
                var planesIntersected = Array<(Array<Point>, Plane)>()
                
                var nearestObject: (Array<Point>, SceneObject)
                for sphere in sphereSet {
                    let intersectionPoints = sphere.isIntersectedBy(ray: ray)
                    if intersectionPoints.count > 0 {
                        spheresIntersected.append((intersectionPoints, sphere))
                    }
                }
                for plane in planeSet {
                    let intersectionPoints = plane.isIntersectedBy(ray: ray)
                    if intersectionPoints.count > 0 {
                        planesIntersected.append((intersectionPoints, plane))
                    }
                }
            }
        }
    }
    
//    convenience init(){
//        let screen = Screen(screenWidth: 1000, screenHeight: 1000, screenU: Vector(x: 1.0, y: 0.0, z: 0.0), screenV: Vector(x: 0.0, y: 0.0, z: 1.0))
//        let eye = Eye(emissionPoint: <#T##Point#>, directionVector: <#T##Vector#>)
//
//        self.init(screen, )
//    }
}
