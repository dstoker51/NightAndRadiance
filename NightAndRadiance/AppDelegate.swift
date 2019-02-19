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
        
        var ppm = PPMWriter(filename: "output.txt", filepath: "/Users/Darin/Library/Containers/dstoker51.NightAndRadiance/Data/Documents/", width: 1024, height: 1024)
        var raster = Array<Array<UInt8>>()
        ppm.write(raster: raster)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

