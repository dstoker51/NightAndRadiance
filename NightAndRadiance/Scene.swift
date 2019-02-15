//
//  Scene.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/8/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

class Scene {
    typealias Eye = Ray
    let screen: Screen
    let eye: Eye
    var objectList: Set<SceneObject>
    
    init(screen: Screen, screenU: Vector, screenV: Vector, eye: Eye, objectList: Set<SceneObject>) {
        self.screen = screen
        self.eye = eye
        self.objectList = objectList
    }
    
//    convenience init(){
//        let screen = Screen(screenWidth: 1000, screenHeight: 1000, screenU: Vector(x: 1.0, y: 0.0, z: 0.0), screenV: Vector(x: 0.0, y: 0.0, z: 1.0))
//        let eye = Eye(emissionPoint: <#T##Point#>, directionVector: <#T##Vector#>)
//
//        self.init(screen, )
//    }
}
