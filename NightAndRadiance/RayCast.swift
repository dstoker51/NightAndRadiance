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
    let objectSet: Set<SceneObject>
    let lightSources: [LightSource]
    let initialRay: Ray
    let tThreshold = 0.00001    // Threshold to keep from intersecting self over and over due to floating point errors.
    let maxDepth = 3
    
    init(initialRay: Ray, objectSet: Set<SceneObject>, lightSources: [LightSource]) {
        self.initialRay = initialRay
        self.objectSet = objectSet
        self.lightSources = lightSources
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(aggregateColor)
        hasher.combine(initialRay)
        hasher.combine(tThreshold)
    }
    
    func trace(ray: Ray) -> Color {
        if let (t, nearestObject) = checkForIntersection(ray: ray) {
            let intersectionPoint = initialRay.pointFrom(t: t)
            
            // Cast shadow rays.
            aggregateColor = aggregateColor + castShadowRay(emissionPoint: intersectionPoint, sourceObject: nearestObject)
            
            // Cast reflective rays (if any).
            
            // Cast refractive rays (if any).
            
            // TODO: Cast ambient light rays.
            
            // Tone map the output color.
            return aggregateColor.clamped()
//            return aggregateColor.applyGammaCorrection(A: 100.0, gamma: 0.5)
//            return aggregateColor.applyBasicToneMap(addition: 0.25)
            
        }
            // Nothing struck by ray.
        else {
            return Color(red: 1.0, green: 1.0, blue: 1.0)   // White
        }
    }
    
    private func checkForIntersection(ray: Ray) -> (Double, SceneObject)? {
        var nearestIntersectedObject: (Double, SceneObject)?
        
        // Iterate over all objects in scene and find the one with the nearest intersection (if any).
        for sceneObject in objectSet {
            let roots = sceneObject.calculateRootsWith(ray: ray)
            if roots.count > 0 {
                for root in roots {
                    if root > 0 && root > tThreshold && (nearestIntersectedObject == nil || root < nearestIntersectedObject!.0) {
                        nearestIntersectedObject = (root, sceneObject)
                    }
                }
            }
        }
        
        return nearestIntersectedObject
    }
    
    private func castShadowRay(emissionPoint: Point, sourceObject: SceneObject) -> Color {
        var aggregateLightColor: Color = Color(red: 0.0, green: 0.0, blue: 0.0)
        for lightSource in lightSources {
            let shadowRay = Ray(emissionPoint: emissionPoint, directionVector: lightSource.worldPosition - emissionPoint)
            // Object struck en-route to light source.
            if let (shadowT, shadowNearestObject) = checkForIntersection(ray: shadowRay) {
                    // TODO: shadowRays are not normalized. This isn't a problem, but the following calculation relies on this fact.
                    // Decide if all vectors should be normalized or not and alter this calculation to fix it if so.
                    // Check if object struck was futher out than the light source. (Use strikable notion of light sources instead of this calculation?)
                if (shadowRay.pointFrom(t: shadowT) - emissionPoint).magnitude <= shadowRay.directionVector.magnitude {
                    // Object in path. Shadowed is default state. Move on to the next light source.
                    continue;
                }
            }
            // No object en-route to light source. Calculate surface intensity.
            aggregateLightColor = aggregateLightColor + calculateSurfaceIntensity(ray: shadowRay, intersectionPoint: emissionPoint, strikableObject: sourceObject, lightSource: lightSource)
        }
        
        return aggregateLightColor
    }
    
    private func calculateSurfaceIntensity(ray: Ray, intersectionPoint: Point, strikableObject: SceneObject, lightSource: LightSource) -> Color {
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
