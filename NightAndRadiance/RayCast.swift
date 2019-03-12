//
//  RayCast.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/23/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class RayCast: Hashable {
    var aggregateColor: Color = Color(red: 0.0, green: 0.0, blue: 0.0)
    let objectSet: Set<Strikeable>
    let lightSources: [LightSource]
    let initialRay: Ray
    let tThreshold = 0.00001    // Threshold to keep from intersecting self over and over due to floating point errors.
    
    init(initialRay: Ray, objectSet: Set<Strikeable>, lightSources: [LightSource]) {
        self.initialRay = initialRay
        self.objectSet = objectSet
        self.lightSources = lightSources
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(aggregateColor)
        hasher.combine(initialRay)
        hasher.combine(tThreshold)
    }
    
    func trace(ray: Ray, over: Set<Strikeable>) -> (Double, Strikeable)? {
        var nearestObject: (Double, Strikeable)?
        for sceneObject in objectSet {
            let roots = sceneObject.calculateRootsWith(ray: ray)
            
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
                    // TODO: shadowRays are not normalized. This isn't a problem, but the following calculation relies on this fact.
                    // Decide if all vectors should be normalized or not and alter this calculation to fix it if so.
                    // Check if object struck was futher out than the light source. (Use strikable notion of light sources instead of thie calculation?)
                    else if (shadowRay.pointFrom(t: shadowT) - intersectionPoint).magnitude > shadowRay.directionVector.magnitude {
                        aggregateColor = aggregateColor + calculateSurfaceIntensity(ray: shadowRay, intersectionPoint: intersectionPoint, strikableObject: nearestObject, lightSource: lightSource)
                    }
                    // Object in path. Shadowed.
//                    aggregateColor = aggregateColor + Color(red: 0, green: 0, blue: 0)    // Shadow is default state.
                }
                // No object en route to light source.
                else {
                    // Calculate surface intensity.
                    aggregateColor = aggregateColor + calculateSurfaceIntensity(ray: shadowRay, intersectionPoint: intersectionPoint, strikableObject: nearestObject, lightSource: lightSource)
                }
            }
            
            return aggregateColor.clamped()

        }
        // Nothing struck by ray.
        else {
            return Color(red: 1.0, green: 1.0, blue: 1.0)   // White
        }
    }
    
    private func calculateSurfaceIntensity(ray: Ray, intersectionPoint: Point, strikableObject: Strikeable, lightSource: LightSource) -> Color {
        let vectorDotNormal = ray.directionVector.normalized().dot(strikableObject.calculateNormalAt(point: intersectionPoint))
        let red = (Double(lightSource.material.color.red * strikableObject.material.color.red) / Color.max) * vectorDotNormal
        let green = (Double(lightSource.material.color.green * strikableObject.material.color.green) / Color.max) * vectorDotNormal
        let blue = (Double(lightSource.material.color.blue * strikableObject.material.color.blue) / Color.max) * vectorDotNormal
        return Color(red: red, green: green, blue: blue)
    }
}

func ==(lhs: RayCast, rhs: RayCast) -> Bool {
    return lhs === rhs
}
