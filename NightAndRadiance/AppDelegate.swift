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
        let sphere1 = Sphere(radius: 10.0, worldPosition: Point(0.0, 0.0, 0.0))
//        print(sphere1)
        let ray1 = Ray(emissionPoint: Point(-20.0, 0.0, 0.0), directionVector: Vector(x:1.0, y:0.0, z:0.0))
//        print(ray1)
        print(sphere1.isIntersectedBy(ray: ray1))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

