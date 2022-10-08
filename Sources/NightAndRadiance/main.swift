//
//  main.swift
//  
//
//  Created by Darin Stoker on 8/14/22.
//

import Foundation

func rayColor(ray: Ray, world: Hittable, depth: Int) -> Color {
    // If we've exceeded the ray bounce limit, no more light is gathered
    if depth <= 0 {
        return Color(red: 0.0, green: 0.0, blue: 0.0)
    }
    var record = HitRecord()
    if (world.hit(ray: ray, tMin: 0.0, tMax: Double.infinity, record: &record)) {
        let target = record.point + record.normal + Vector4D.randomInUnitSphere()
        return rayColor(ray: Ray(emissionPoint: record.point, directionVector: target - record.point), world: world, depth: depth - 1) * 0.5
    }
    let unitDirection = ray.directionVector.normalized()
    let t = 0.5 * (unitDirection.y + 1.0)
    return Color(red: 1.0, green: 1.0, blue: 1.0) * (1.0 - t) + Color(red: 0.5, green: 0.7, blue: 1.0) * t
}

// Image
let aspectRatio = 16.0/9.0
let imageWidth = 400
let imageHeight = Int(Double(imageWidth) / aspectRatio)
let samplesPerPixel = 100
let maxDepth = 10

// World
var world: Hittables = .init()
world.add(hittableObject: Sphere(center: Point3D(0.0, 0.0, -1.0), radius: 0.5))
world.add(hittableObject: Sphere(center: Point3D(0.0, -100.5, -1.0), radius: 100.0))

// Camera
let camera = Camera()

// Trace
var raster: Array<Color> = []
for j in stride(from: imageHeight, to: 0, by: -1) {
    print ("Scanlines remaining: \(j)")
    for i in stride(from: 0, to: imageWidth, by: 1) {
        var pixelColor = Color(red: 0.0, green: 0.0, blue: 0.0)
        for _ in 0..<samplesPerPixel {
            //TODO: Inclusive?
            let u = (Double(i) + Double.random(in: 0.0..<1.0)) / (Double(imageWidth) - 1.0)
            let v = (Double(j) + Double.random(in: 0.0..<1.0)) / (Double(imageHeight) - 1.0)
            let ray = camera.getRay(u: u, v: v)
            pixelColor = pixelColor + rayColor(ray: ray, world: world, depth: maxDepth)
        }
        raster.append(pixelColor / Double(samplesPerPixel))
    }
}

let writer = PPMWriter(filename: "test.ppm", filepath: "/Users/dstoker/Downloads/", width: imageWidth, height: imageHeight)
writer.write(raster: raster)
