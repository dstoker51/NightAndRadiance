//
//  SceneObjects.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/8/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

protocol SceneObject: Hashable {
    var worldPosition: Point { get set }
    var red: UInt8 { get set }
    var green: UInt8 { get set }
    var blue: UInt8 { get set }
}

