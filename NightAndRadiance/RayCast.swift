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
    let rayTree: RayNode
    let objectSet: Set<AnyHashable> // TODO: Use reference instead.
    let lightSources: [LightSource]   // TODO: Use reference instead.
    let ambientLighting: Color
    let tThreshold = 0.00001    // Threshold to keep from intersecting self over and over due to floating point errors.
    
    init(initialRay: Ray, objectSet: Set<AnyHashable>, lightSources: [LightSource], ambientLighting: Color) {
        rayTree = RayNode(ray: initialRay)
        self.objectSet = objectSet
        self.lightSources = lightSources
        self.ambientLighting = ambientLighting
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
    
    func run() -> Color {
        // Fill in the data for the first node.
        if let (t, nearestObject) = trace(ray: rayTree.ray, over: objectSet) {
            rayTree.intersectionPoint = rayTree.ray.pointFrom(t: t)
            rayTree.sceneObject = nearestObject
            
            // Cast shadow rays.
            for lightSource in lightSources {
                if let emissionPoint = rayTree.intersectionPoint {
                    let shadowRay = Ray(emissionPoint: emissionPoint, directionVector: lightSource.worldPosition - emissionPoint)
                    // Object struck en route to light sourece.
                    if let (shadowT, shadowNearestObject) = trace(ray: shadowRay, over: objectSet) {
                        // Object in path. Shadowed.
                        return Color(red: 0, green: 0, blue: 0)
                    }
                    // No object in path to light source.
                    else {
                        // Calculate surface intensity.
                        if let sphere = rayTree.sceneObject as? Sphere {
                            let vectorDotNormal = shadowRay.directionVector.normalized().dot(sphere.calculateNormalAt(point: rayTree.intersectionPoint!))
                            let red = (Double(lightSource.color.red * sphere.material.color.red) / Color.max) * vectorDotNormal
                            let green = (Double(lightSource.color.green * sphere.material.color.green) / Color.max) * vectorDotNormal
                            let blue = (Double(lightSource.color.blue * sphere.material.color.blue) / Color.max) * vectorDotNormal
                            return Color(red: Int(red), green: Int(green), blue: Int(blue))
                        }
                        else if let plane = rayTree.sceneObject as? Plane {
                            let vectorDotNormal = shadowRay.directionVector.normalized().dot(plane.calculateNormalAt(point: rayTree.intersectionPoint!))
                            let red = (Double(lightSource.color.red * plane.material.color.red) / Color.max) * vectorDotNormal
                            let green = (Double(lightSource.color.green * plane.material.color.green) / Color.max) * vectorDotNormal
                            let blue = (Double(lightSource.color.blue * plane.material.color.blue) / Color.max) * vectorDotNormal
                            return Color(red: Int(red), green: Int(green), blue: Int(blue))
                        }
                        else {
                            return(Color(red: 0, green: 0, blue: 0))
                        }
                    }
                }
            }
            
            // Return the color.
            if let nearestSphere = nearestObject as? Sphere {
                return nearestSphere.material.color
            }
            else if let nearestPlane = nearestObject as? Plane {
                return nearestPlane.material.color
            }
            else {
                return Color(red: 0, green: 0, blue: 0)
            }
        }
            // Nothing struck by ray.
        else {
            return Color(red: 255, green: 255, blue: 255)
        }
    }
}
