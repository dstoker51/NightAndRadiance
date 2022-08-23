//
//  main.swift
//  
//
//  Created by Darin Stoker on 8/14/22.
//

import Foundation

// Image
let aspectRatio = 16.0/9.0
let imageWidth = 800
let imageHeight = Int(Double(imageWidth) / aspectRatio)

// Camera
let viewportHeight = 2.0
let viewportWidth = aspectRatio * viewportHeight
let focalLength = 1.0

let origin = Point3D(0, 0, 0)
let horizontal = Vector4D(x: viewportWidth, y: 0.0, z: 0.0)
let vertical = Vector4D(x: 0.0, y: viewportHeight, z: 0.0)
let lowerLeftCorner = origin - horizontal/2.0 - vertical/2.0 - Vector4D(x: 0.0, y: 0.0, z: focalLength)

// Sphere
func hitSphere(center: Point3D, radius: Double, ray: Ray) -> Double {
    let centerToOrigin = ray.emissionPoint - center
    let a = ray.directionVector.dot(ray.directionVector)
    let b = 2.0 * centerToOrigin.dot(ray.directionVector)
    let c = centerToOrigin.dot(centerToOrigin) - radius * radius
    let discriminant = b * b - 4 * a * c
    if discriminant < 0 {
        return -1.0
    } else {
        return (-b - sqrt(discriminant)) / (2.0 * a)
    }
}

// Render
func rayColor(ray: Ray) -> Color {
    var t = hitSphere(center: Point3D(0.0, 0.0, -1.0), radius: 0.5, ray: ray)
    if t > 0.0 {
        let N = Vector4D(point: ray.at(t: t) - Vector4D(x: 0.0, y: 0.0, z: -1.0)).normalized()
        return Color(red: N.x + 1, green: N.y + 1, blue: N.z + 1) * 0.5
    }
    let unitDirection = ray.directionVector.normalized()
    t = 0.5 * (unitDirection.y + 1.0)
    return Color(red: 1.0, green: 1.0, blue: 1.0) * (1.0 - t) + Color(red: 0.5, green: 0.7, blue: 1.0) * t
}

var raster: Array<Color> = []
for j in stride(from: imageHeight, to: 0, by: -1) {
    print ("Scanlines remaining: \(j)")
    for i in stride(from: 0, to: imageWidth, by: 1) {
        let u = Double(i) / Double(imageWidth)
        let v = Double(j) / Double(imageHeight)
        let r = Ray(emissionPoint: origin, directionVector: lowerLeftCorner + horizontal * u + vertical * v - origin)
        let pixelColor = rayColor(ray: r)
        raster.append(pixelColor)
    }
}

let writer = PPMWriter(filename: "test.ppm", filepath: "/Users/dstoker/Downloads/", width: imageWidth, height: imageHeight)
writer.write(raster: raster)
