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
    let lightSources: [Point]   // TODO: Use reference instead.
    let tThreshold = 0.00001    // Threshold to keep from intersecting self over and over due to floating point errors.
    
    init(initialRay: Ray, objectSet: Set<AnyHashable>, lightSources: [Point]) {
        rayTree = RayNode(ray: initialRay)
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
    
    func run() -> Color {
        // Fill in the data for the first node.
        if let (t, nearestObject) = trace(ray: rayTree.ray, over: objectSet) {
            rayTree.intersectionPoint = rayTree.ray.pointFrom(t: t)
            rayTree.sceneObject = nearestObject
            
            // Cast shadow rays.
            for lightSource in lightSources {
                if let emissionPoint = rayTree.intersectionPoint {
                    let shadowRay = Ray(emissionPoint: emissionPoint, directionVector: lightSource - emissionPoint)
                    // TODO: Track object and check for reflection/refraction.
                    if let (_, _) = trace(ray: shadowRay, over: objectSet) {
                        // Object in path. Shadowed.
                        return Color(red: 0, green: 0, blue: 0)
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
        else {
            return Color(red: 255, green: 255, blue: 255)
        }
    }
}
