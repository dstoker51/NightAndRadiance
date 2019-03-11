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
        let width: UInt32 = 1000
        let height: UInt32 = 1000
        let screen = Screen(screenU: Vector(x: 1.0, y: 0.0, z: 0.0), screenV: Vector(x: 0.0, y: 1.0, z: 0.0), worldPosition: Point(0.0, 0.0, 0.0), widthInPixels: width, heightInPixels: height)
        
        var scene = Scene(screen: screen, eye: Point(0.0, 0.0, 1.25))
//        scene.lightSources.append(LightSource(worldPosition: Point(0.0, 10.0, -3.0), color: Color(red: 255, green: 255, blue: 255)))
        scene.lightSources.append(LightSource(worldPosition: Point(0.0, 0.0, 0.0), color: Color(red: 255, green: 255, blue: 255)))
        scene.objectSet.insert(Sphere(radius: 1.0, worldPosition: Point(0.0, 0.0, -3.0), material: Material(red: 255, green: 0, blue: 0)))
//        scene.objectSet.insert(Sphere(radius: 0.5, worldPosition: Point(0.0, 2.0, -3.0), material: Material(red: 255, green: 255, blue: 0)))
//        scene.objectSet.insert(Sphere(radius: 1.0, worldPosition: Point(3.0, 3.0, -5.0), material: Material(red: 0, green: 255, blue: 0)))
//        scene.objectSet.insert(Sphere(radius: 1.0, worldPosition: Point(-3.0, 3.0, -5.0), material: Material(red: 0, green: 0, blue: 255)))
        scene.objectSet.insert(Plane(vectorU: Vector(x: 0.0, y: 0.0, z: 1.0), vectorV: Vector(x: 1.0, y: 0.0, z: 0.0), worldPosition: Point(0.0, -1.5, 0.0), material: Material(red: 0, green: 255, blue: 255)))
        scene.castRays()
        
        let ppm = PPMWriter(filename: "output.ppm", filepath: "/Users/Darin/Library/Containers/dstoker51.NightAndRadiance/Data/Documents/", width: Int(width), height: Int(height))
        ppm.write(raster: scene.screen.raster)
        print("Done.")
        
        // Close the app.
        NSApplication.shared.terminate(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        print("Terminating application.")
    }


}

