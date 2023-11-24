//
//  Vector.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 3/18/18.
//  Copyright © 2018 Darin Stoker. All rights reserved.
//

import Foundation

/// A 4D vector that implements the standard mathematical operations including dot, cross, normalize, invert, etc.
struct Vector: Hashable, CustomStringConvertible {
    var x, y, z: Double
    var description: String { return "<x: \(x), y: \(y), z: \(z)>" }

    /// A vector described by x, y, and z components.
    /// Uses homogenous coordiate systems, i.e (x, y, z) represents (x, y, z).
    ///
    /// - Parameters:
    ///   - x: X component of the vector.
    ///   - y: Y component of the vector.
    ///   - z: Z component of the vector.
    init(x: Double, y: Double, z: Double) {
        if x.isNaN || y.isNaN || z.isNaN {
            self.x = 0.0
            self.y = 0.0
            self.z = 0.0
        }
        else {
            self.x = x
            self.y = y
            self.z = z
        }
    }

    /// A vector described by the vector magnitude and the two angles required to position it in 3D space.
    ///
    /// - Parameters:
    ///   - r: Magnitude of vector.
    ///   - theta1: XY angle.
    ///   - theta2: YZ angle.
    init(r: Double, theta1: Double, theta2 : Double) {
        self.init(x: r * cos(theta1), y: r * sin(theta1), z: r * sin(theta2))
    }

    /// A vector copy operation.
    ///
    /// - Parameter vector: Vector to copy.
    init(_ vector: Vector) {
        self.init(x: vector.x, y: vector.y, z: vector.z)
    }

    /// Dot operation between two vectors.
    ///
    /// - Parameter vector: Vector with which to perform the dot operation.
    /// - Returns: Value representing the "likeness" of the two vectors.
    func dot(_ vector: Vector) -> Double {
        return x * vector.x + y * vector.y + z * vector.z
    }

    /// Cross operation between two vectors.
    ///
    /// - Parameter vector: Vector with which to perform the cross product operation.
    /// - Returns: Vector orthogonal to the input vectors, scaled by their magnitudes.
    func cross(_ vector: Vector) -> Vector {
        let compX = y * vector.z - z * vector.y
        let compY = z * vector.x - x * vector.z
        let compZ = x * vector.y - y * vector.x
        return Vector(x: compX, y: compY, z: compZ)
    }

    /// Length of the vector in 3D space.
    var magnitude: Double {
        return sqrt(x * x + y * y + z * z)
    }
    
    /// Inverts the vector (reverses direction in x, y, and z).
    mutating func invert(){
        x = -x
        y = -y
        z = -z
    }

    /// Inverting a vector reverses its direction in x, y, and z.
    ///
    /// - Returns: Inverted vector.
    func inverted() -> Vector {
        return Vector(x: -x, y: -y, z: -z)
    }
    
    /// Normalizes the vector, making the magnitude equal to 1.0 by scaling x, y, and z components but pointing in the same direction.
    mutating func normalize() {
        let scale = 1/magnitude
        x = x * scale
        y = y * scale
        z = z * scale
    }

    /// Returns a normalized vector, making the magnitude equal to 1.0 by scaling x, y, and z components but pointing in the same direction.
    ///
    /// - Returns: The normalized vector.
    func normalized() -> Vector {
        return self / self.magnitude
    }
    
    /// Adds two vectors together.
    ///
    /// - Parameters:
    ///   - v1: First vector.
    ///   - v2: Second vector.
    /// - Returns: Resultant vector
    static func +(v1: Vector, v2: Vector) -> Vector {
        return Vector(x: v1.x + v2.x, y: v1.y + v2.y, z: v1.z + v2.z)
    }
    
    static func +=(v1: inout Vector, v2: Vector) {
        v1 = v1 + v2
    }
    
    /// Subracts second vector from the first.
    ///
    /// - Parameters:
    ///   - v1: First vector.
    ///   - v2: Second vector.
    /// - Returns: Resultant vector
    static func -(v1: Vector, v2: Vector) -> Vector {
        return Vector(x: v1.x - v2.x, y: v1.y - v2.y, z: v1.z - v2.z)
    }
    
    static func -=(v1: inout Vector, v2: Vector) {
        v1 = v1 - v2
    }
    
    /// Multiplies a vector by a scalar, resulting in a vector with a scaled magnitude and direction.
    ///
    /// - Parameters:
    ///   - vector: Vector to scale.
    ///   - scalar: Value by which to multiply.
    /// - Returns: Scaled vector.
    static func *(vector: Vector, scalar: Double) -> Vector {
        return Vector(x: vector.x * scalar, y: vector.y * scalar, z: vector.z * scalar)
    }
    
    static func *=(vector: inout Vector, scalar: Double) {
        vector = vector * scalar
    }
    
    /// Multiplies a vector by another vector, resulting in a vector with each component scaled by the other vectors corresponding component.
    ///
    /// - Parameters:
    ///   - v1: Vector to scale.
    ///   - v2: Vector by which to multiply
    /// - Returns: Scaled vector.
    static func *(v1: Vector, v2: Vector) -> Vector {
        return Vector(x: v1.x * v2.x, y: v1.y * v2.y, z: v1.z * v2.z)
    }
    
    static func *=(v1: inout Vector, v2: Vector) {
        v1 = v1 * v2
    }
    
    /// Divides a vector by a scalar, resulting in a vector with a scaled magnitude and direction.
    ///
    /// - Parameters:
    ///   - vector: Vector to scale.
    ///   - scalar: Value by which to divide.
    /// - Returns: Scaled vector.
    static func /(vector: Vector, scalar: Double) -> Vector {
        return vector * (1.0 / scalar)
    }
    
    static func /=(vector: inout Vector, scalar: Double) {
        vector = vector / scalar
    }
    
    /// Divides a vector by another vector, resulting in a vector with each component scaled by the other vectors corresponding component.
    ///
    /// - Parameters:
    ///   - v1: Vector to scale.
    ///   - v2: Vector with which to divide
    /// - Returns: Scaled vector.
    static func /(v1: Vector, v2: Vector) -> Vector {
        return Vector(x: v1.x / v2.x, y: v1.y / v2.y, z: v1.z / v2.z)
    }
    
    static func /=(v1: inout Vector, v2: Vector) {
        v1 = v1 / v2
    }
}

extension Vector {
    @inlinable
    static func random() -> Vector {
        //TODO: Inclusive?
        Vector(x: Double.random(in: 0.0..<1.0), y: Double.random(in: 0.0..<1.0), z: Double.random(in: 0.0..<1.0))
    }

    @inlinable
    static func random(minValue: Double, maxValue: Double) -> Vector {
        let max = max(minValue, maxValue)
        let min = min(minValue, maxValue)
        //TODO: Inclusive?
        return Vector(x: Double.random(in: min..<max), y: Double.random(in: min..<max), z: Double.random(in: min..<max))
    }

    @inlinable
    static func randomInUnitSphere() -> Vector {
        while true {
            let p = random(minValue: -1.0, maxValue: 1.0)
            if (p.magnitude * p.magnitude) >= 1.0 {
                continue
            }
            return p
        }
    }
}
