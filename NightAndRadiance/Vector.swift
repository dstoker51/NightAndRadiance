//
//  Vector.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 3/18/18.
//  Copyright © 2018 Darin Stoker. All rights reserved.
//

import Foundation

class Vector {
    var x, y, z, w: Double

    // Uses homogenous coordiate systems, i.e (x, y, z, w) represents (x/w, y/w, z/w).
    init?(x: Double, y: Double, z: Double, w: Double) {
        guard w != 0.0 && !x.isNaN && !y.isNaN && !z.isNaN && !w.isNaN else {
            return nil  //TODO: Technically, this could return a point at infinity instead of nil.
        }
        self.x = x/w
        self.y = y/w
        self.z = z/w
        self.w = 1.0
    }

    convenience init?(x: Double, y: Double, z: Double) {
        self.init(x: x, y: y, z: z, w: 1.0)
    }

    convenience init?(r: Double, theta1: Double, theta2 : Double, w: Double) {
        self.init(x: r * cos(theta1), y: r * sin(theta1), z: r * sin(theta2), w: w)
    }

    convenience init?(r: Double, theta1: Double, theta2 : Double) {
        self.init(r: r, theta1: theta1, theta2: theta2, w: 1.0)
    }

    convenience init?(_ vector: Vector) {
        self.init(x: vector.x, y: vector.y, z: vector.z, w: vector.w)
    }

    func dot(_ vector: Vector) -> Double {
        return x * vector.x + y * vector.y + z * vector.z
    }

    func cross(_ vector: Vector) -> Vector? {
        let compX = y * vector.z - z * vector.y
        let compY = z * vector.x - x * vector.z
        let compZ = x * vector.y - y * vector.x
        return Vector(x: compX, y: compY, z: compZ)
    }

    var magnitude: Double {
        return sqrt(x * x + y * y + z * z)
    }

    func invert(){
        x = -x
        y = -y
        z = -z
    }

    func inverted() -> Vector? {
        return Vector(x: -x, y: -y, z: -z)
    }

    func normalize() {
        let scale = 1/magnitude
        x = x * scale
        y = y * scale
        z = z * scale
    }

    func normalized() -> Vector? {
        let scale = 1/magnitude
        return Vector(x: x * scale, y: y * scale, z: z * scale)
    }
}

func +(v1: Vector, v2: Vector) -> Vector {
    return Vector(x: v1.x + v2.x, y: v1.y + v2.y, z: v1.z + v2.z)!
}

func -(v1: Vector, v2: Vector) -> Vector {
    return Vector(x: v1.x - v2.x, y: v1.y - v2.y, z: v1.z - v2.z)!
}

func *(vector: Vector, scalar: Double) -> Vector {
    return Vector(x: vector.x * scalar, y: vector.y * scalar, z: vector.z * scalar)!
}

func ==(v1: Vector, v2: Vector) -> Bool {
    return (v1.x == v2.x && v1.y == v2.y && v1.z == v2.z ? true : false)
}
