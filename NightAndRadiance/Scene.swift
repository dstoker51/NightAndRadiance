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
    var screen: Screen
    let eye: Eye
//    var objectSet: Set<SceneObject> // Swift does yet have generalized existentials (see https://github.com/apple/swift/blob/master/docs/GenericsManifesto.md#generalized-existentials)
    
    // TODO Figure out how to generalize this.
    var sphereSet = Set<Sphere>()
    var planeSet = Set<Plane>()
    
    init(screen: Screen, eye: Point) {
        self.screen = screen
        self.eye = eye
    }
    
    func trace() {
        for x in 0...screen.widthInPixels - 1 {
            for y in 0...screen.heightInPixels - 1 {
                let pixelLocation: Point = screen.worldCoordinateFor(pixelU: x, pixelV: y)
                let ray: Ray = Ray(emissionPoint: eye, directionVector: Vector(point1: eye, point2: pixelLocation))
                print(ray)
                
                let dummySphere = Sphere(radius: 0.0, worldPosition: Point(Double.infinity, Double.infinity, Double.infinity), red: 0, green: 0, blue: 0)
                var nearestSphere: (Double, Sphere) = (Double.infinity, dummySphere)
                for sphere in sphereSet {
                    let roots = sphere.calculateRootsWith(ray: ray)
                    // TODO Use the intersection location to find the color at that point (assuming the objects have varying colors).
                    if roots.count > 0 {
                        for root in roots {
                            if root > 0 && root < nearestSphere.0 {
                                nearestSphere = (root, sphere)
                            }
                        }
                    }
                }
                if nearestSphere.0 != Double.infinity {
                    screen.insertColorAtPixel(x: Int(x), y: Int(y), red: nearestSphere.1.red, green: nearestSphere.1.green, blue: nearestSphere.1.blue)
                }
            }
        }
    }
}
