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
    typealias LightSource = Point
    var screen: Screen
    let eye: Eye
    var objectSet = Set<AnyHashable>() // Swift does yet have generalized existentials (see https://github.com/apple/swift/blob/master/docs/GenericsManifesto.md#generalized-existentials)
    
    init(screen: Screen, eye: Point) {
        self.screen = screen
        self.eye = eye
    }
    
    func trace(ray: Ray) -> (Double, AnyHashable)? {
        var nearestSphere: (Double, AnyHashable)?
        for sceneObject in objectSet {
            // TODO: Use protocol instead of if-else branches.
            let roots: [Double]
            if let sphere = sceneObject as? Sphere {
                roots = sphere.calculateRootsWith(ray: ray)
            }
            else if let plane = sceneObject as? Plane {
                roots = plane.calculateRootsWith(ray: ray)
            }
            else {
                roots = []
            }
            
            // TODO: Use the intersection location to find the color at that point (assuming the objects have varying colors).
            if roots.count > 0 {
                for root in roots {
                    if root > 0 && (nearestSphere == nil || root < nearestSphere!.0) {
                        nearestSphere = (root, sceneObject)
                    }
                }
            }
        }
        return nearestSphere
    }
    
    func castShadowRay(light: LightSource, emissionPoint: Point, depth: Int) -> Bool {
        let ray = Ray(emissionPoint: emissionPoint, directionVector: Vector(point1: emissionPoint, point2: light), depth: depth)
//        let nearestSphere = trace(ray: ray)
//        if nearestSphere.0 != Double.infinity {
//            screen.insertColorAtPixel(x: Int(x), y: Int(y), red: nearestSphere.1.red, green: nearestSphere.1.green, blue: nearestSphere.1.blue)
//        }
        
        return false
    }
    
    func castRays() {
        for x in 0...screen.widthInPixels - 1 {
            for y in 0...screen.heightInPixels - 1 {
                let pixelLocation: Point = screen.worldCoordinateFor(pixelU: x, pixelV: y)
                let ray: Ray = Ray(emissionPoint: eye, directionVector: Vector(point1: eye, point2: pixelLocation), depth: 0)
                
                let nearestObject = trace(ray: ray)
                if let nearestSphere = nearestObject?.1 as? Sphere {
                    screen.insertColorAtPixel(x: Int(x), y: Int(y), red: nearestSphere.red, green: nearestSphere.green, blue: nearestSphere.blue)
                }
                else if let nearestPlane = nearestObject?.1 as? Plane {
                    screen.insertColorAtPixel(x: Int(x), y: Int(y), red: nearestPlane.red, green: nearestPlane.green, blue: nearestPlane.blue)
                }
            }
        }
    }
}
