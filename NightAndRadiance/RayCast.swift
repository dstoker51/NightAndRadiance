//
//  RayCast.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/23/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct RayCast: Hashable {
    var aggregateColor: Color = Color(red: 0, green: 0, blue: 0)
    let objectSet: Set<AnyHashable> // TODO: Use reference instead.
    let lightSources: [LightSource]   // TODO: Use reference instead.
    let initialRay: Ray
    let tThreshold = 0.00001    // Threshold to keep from intersecting self over and over due to floating point errors.
    
    init(initialRay: Ray, objectSet: Set<AnyHashable>, lightSources: [LightSource]) {
        self.initialRay = initialRay
        self.objectSet = objectSet
        self.lightSources = lightSources
    }
    
    func trace(ray: Ray, over: Set<AnyHashable>) -> (Double, AnyHashable)? {
        var nearestObject: (Double, AnyHashable)?
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
                    if root > 0 && root > tThreshold && (nearestObject == nil || root < nearestObject!.0) {
                        nearestObject = (root, sceneObject)
                    }
                }
            }
        }
        return nearestObject
    }
    
    mutating func run() -> Color {
        // Fill in the data for the first node.
        if let (t, nearestObject) = trace(ray: initialRay, over: objectSet) {
            let intersectionPoint = initialRay.pointFrom(t: t)
            
            // Cast shadow rays.
            for lightSource in lightSources {
                let shadowRay = Ray(emissionPoint: intersectionPoint, directionVector: lightSource.worldPosition - intersectionPoint)
                // Object struck en route to light source.
                if let (shadowT, shadowNearestObject) = trace(ray: shadowRay, over: objectSet) {
                    if shadowNearestObject == nearestObject {
                        print("Self-intersection.")
                    }
                    // Object in path. Shadowed.
//                    aggregateColor = aggregateColor + Color(red: 0, green: 0, blue: 0)    // Shadow is default state.
                }
                // No object en route to light source.
                else {
                    // Calculate surface intensity.
                    if let sphere = nearestObject as? Sphere {
                        let vectorDotNormal = shadowRay.directionVector.normalized().dot(sphere.calculateNormalAt(point: intersectionPoint))
                        let red = (Double(lightSource.color.red * sphere.material.color.red) / Color.max) * vectorDotNormal
                        let green = (Double(lightSource.color.green * sphere.material.color.green) / Color.max) * vectorDotNormal
                        let blue = (Double(lightSource.color.blue * sphere.material.color.blue) / Color.max) * vectorDotNormal
                        aggregateColor = aggregateColor + Color(red: red, green: green, blue: blue)
                    }
                    else if let plane = nearestObject as? Plane {
                        let vectorDotNormal = shadowRay.directionVector.normalized().dot(plane.calculateNormalAt(point: intersectionPoint))
                        let red = (Double(lightSource.color.red * plane.material.color.red) / Color.max) * vectorDotNormal
                        let green = (Double(lightSource.color.green * plane.material.color.green) / Color.max) * vectorDotNormal
                        let blue = (Double(lightSource.color.blue * plane.material.color.blue) / Color.max) * vectorDotNormal
                        aggregateColor = aggregateColor + Color(red: red, green: green, blue: blue)
                    }
                }
            }
            
            return aggregateColor.clamped()
            
//            // Return the color.
//            if let nearestSphere = nearestObject as? Sphere {
////                aggregateColor = aggregateColor + nearestSphere.material.color
//                return aggregateColor
//            }
//            else if let nearestPlane = nearestObject as? Plane {
////                aggregateColor = aggregateColor + nearestPlane.material.color
//                return aggregateColor
//            }
//            else {
//                return Color(red: 0, green: 0, blue: 0)
//            }
        }
        // Nothing struck by ray.
        else {
            return Color(red: 255, green: 255, blue: 255)   // White
        }
    }
}
