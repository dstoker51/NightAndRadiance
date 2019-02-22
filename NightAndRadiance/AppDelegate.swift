//
//  AppDelegate.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 3/11/18.
//  Copyright © 2018 Darin Stoker. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        let sphere1 = Sphere(radius: 10.0, worldPosition: Point(0.0, 0.0, 0.0))
////        print(sphere1)
//        let ray1 = Ray(emissionPoint: Point(-20.0, 0.0, 0.0), directionVector: Vector(x:1.0, y:0.0, z:0.0))
////        print(ray1)
//        print(sphere1.isIntersectedBy(ray: ray1))
//
//        let plane1 = Plane(vectorU: Vector(x:0.0, y:0.0, z:1.0), vectorV: Vector(x:0.0, y:1.0, z:0.0), worldPosition: Point(0.0, 0.0, -1.0))
//        print(plane1.isIntersectedBy(ray: ray1))
        
        let width: UInt32 = 1000
        let height: UInt32 = 1000
        let screen = Screen(screenU: Vector(x: 1.0, y: 0.0, z: 0.0), screenV: Vector(x: 0.0, y: 1.0, z: 0.0), worldPosition: Point(0.0, 0.0, 0.0), widthInPixels: width, heightInPixels: height)
        
        let scene = Scene(screen: screen, eye: Point(0.0, 0.0, 1.0))
        scene.sphereSet.insert(Sphere(radius: 1.0, worldPosition: Point(0.0, 0.0, -5.0), red: 255, green: 0, blue: 0))
        scene.sphereSet.insert(Sphere(radius: 1.0, worldPosition: Point(2.0, 2.0, -5.0), red: 0, green: 255, blue: 0))
        scene.sphereSet.insert(Sphere(radius: 1.0, worldPosition: Point(-2.0, 2.0, -5.0), red: 0, green: 0, blue: 255))
        scene.trace()
        
        let ppm = PPMWriter(filename: "output.ppm", filepath: "/Users/Darin/Library/Containers/dstoker51.NightAndRadiance/Data/Documents/", width: Int(width), height: Int(height))
//        var raster: Array<Array<UInt8>>
//        raster = [[255, 0, 255], [0, 0, 0], [255, 0, 255], [0, 0, 0], [255, 0, 255], [0, 0, 0], [255, 0, 255], [0, 0, 0], [255, 0, 255], [0, 0, 0], [255, 0, 255], [0, 0, 0], [255, 0, 255], [0, 0, 0], [255, 0, 255], [0, 0, 0], [255, 0, 255], [0, 0, 0], [255, 0, 255], [0, 0, 0], [255, 0, 255], [0, 0, 0], [255, 0, 255], [0, 0, 0], [255, 0, 255]]
        ppm.write(raster: scene.screen.raster)
        print("Done.")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

