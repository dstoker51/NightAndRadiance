//
//  NightAndRadianceTests.swift
//  NightAndRadianceTests
//
//  Created by Darin Stoker on 3/11/18.
//  Copyright © 2018 Darin Stoker. All rights reserved.
//

import XCTest
@testable import NightAndRadiance

class VectorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    //----------------------------------------------------------------------------------------------------------------------------------
    // MARK: - Initializer Tests
    //----------------------------------------------------------------------------------------------------------------------------------

    func testCreateXYZ() {
        let vector = Vector(x: 1.25, y: 2.25, z: 3.25)
        XCTAssert(vector.x == 1.25, "X doesn't equal 1.25")
        XCTAssert(vector.y == 2.25, "Y doesn't equal 2.25")
        XCTAssert(vector.z == 3.25, "Z doesn't equal 3.25")
    }

    func testCreateXYZWithZeros() {
        let vector = Vector(x: 0.0, y: 0.0, z: 0.0)
        XCTAssert(vector.x == 0.0, "X doesn't equal 0.0")
        XCTAssert(vector.y == 0.0, "Y doesn't equal 0.0")
        XCTAssert(vector.z == 0.0, "Z doesn't equal 0.0")
    }

    func testCreateRThetas() {
        let vector = Vector(r: 2, theta1: Double.pi/4.0, theta2: Double.pi/4.0)
        XCTAssertEqual(vector.x, sqrt(2), accuracy: 0.000000001, "X should equal \(sqrt(2)), actually is \(vector.x)")
        XCTAssertEqual(vector.y, sqrt(2), accuracy: 0.000000001, "Y should equal \(sqrt(2)), actually is \(vector.y)")
        XCTAssertEqual(vector.z, sqrt(2), accuracy: 0.000000001, "Z should equal \(sqrt(2)), actually is \(vector.z)")
    }

    func testCreateRThetasWithZeroRadius() {
        let vector = Vector(r: 0.0, theta1: Double.pi/4.0, theta2: Double.pi/4.0)
        XCTAssertEqual(vector.x, 0.0, accuracy: 0.000000001, "X should equal 0.0, actually is \(vector.x)")
        XCTAssertEqual(vector.y, 0.0, accuracy: 0.000000001, "Y should equal 0.0, actually is \(vector.y)")
        XCTAssertEqual(vector.z, 0.0, accuracy: 0.000000001, "Z should equal 0.0, actually is \(vector.z)")
    }

    func testCreateRThetasWithZeroThetas() {
        let vector = Vector(r: 2.0, theta1: 0.0, theta2: 0.0)
        XCTAssertEqual(vector.x, 2.0, accuracy: 0.000000001, "X should equal 2.0, actually is \(vector.x)")
        XCTAssertEqual(vector.y, 0.0, accuracy: 0.000000001, "Y should equal 0.0, actually is \(vector.y)")
        XCTAssertEqual(vector.z, 0.0, accuracy: 0.000000001, "Z should equal 0.0, actually is \(vector.z)")
    }

    func testCreateRThetasWithAllZeros() {
        let vector = Vector(r: 0.0, theta1: 0.0, theta2: 0.0)
        XCTAssertEqual(vector.x, 0.0, accuracy: 0.000000001, "X should equal 0.0, actually is \(vector.x)")
        XCTAssertEqual(vector.y, 0.0, accuracy: 0.000000001, "Y should equal 0.0, actually is \(vector.y)")
        XCTAssertEqual(vector.z, 0.0, accuracy: 0.000000001, "Z should equal 0.0, actually is \(vector.z)")
    }

    func testCreateWithVector() {
        let originalVector = Vector(x: 7.5, y: 8.5, z: 9.5)
        let vectorCopy = Vector(originalVector)
        XCTAssertEqual(vectorCopy.x, 7.5)
        XCTAssertEqual(vectorCopy.y, 8.5)
        XCTAssertEqual(vectorCopy.z, 9.5)
    }

    //----------------------------------------------------------------------------------------------------------------------------------
    // MARK: - Method Tests
    //----------------------------------------------------------------------------------------------------------------------------------

    func testDotProductBasic() {
        let vector1 = Vector(x: 1.0, y: 1.0, z: 1.0)
        let vector2 = Vector(x: 0.0, y: 0.0, z: 0.0)
        let scalarDot = vector1.dot(vector2)
        XCTAssertEqual(scalarDot, 0.0)
    }

    func testDotProductBasicSameVector() {
        let vector = Vector(x: 1.0, y: 1.0, z: 1.0)
        let scalarDot = vector.dot(vector)
        XCTAssertEqual(scalarDot, 3.0)
    }

    func testDotProductBothNegative() {
        let vector1 = Vector(x: -1.0, y: -1.0, z: -1.0)
        let vector2 = Vector(x: -1.0, y: -1.0, z: -1.0)
        let scalarDot = vector1.dot(vector2)
        XCTAssertEqual(scalarDot, 3.0)
    }

    func testDotProductNegativeAndPositive() {
        let vector1 = Vector(x: -1.0, y: -1.0, z: -1.0)
        let vector2 = Vector(x: 1.0, y: 1.0, z: 1.0)
        let scalarDot = vector1.dot(vector2)
        XCTAssertEqual(scalarDot, -3.0)
    }

    func testCrossProductBasic() {
        let vector1 = Vector(x: 1.0, y: 0.0, z: 0.0)
        let vector2 = Vector(x: 0.0, y: 1.0, z: 0.0)
        let crossVector = vector1.cross(vector2)
        XCTAssertEqual(crossVector.x, 0.0)
        XCTAssertEqual(crossVector.y, 0.0)
        XCTAssertEqual(crossVector.z, 1.0)
    }

    func testCrossProductDifferentLengths() {
        let vector1 = Vector(x: 2.0, y: 0.0, z: 0.0)
        let vector2 = Vector(x: 0.0, y: 3.0, z: 0.0)
        let crossVector = vector1.cross(vector2)
        XCTAssertEqual(crossVector.x, 0.0)
        XCTAssertEqual(crossVector.y, 0.0)
        XCTAssertEqual(crossVector.z, 6.0)
    }

    func testCrossProductDifferentAngles() {
        let vector1 = Vector(x: 1.0, y: 1.0, z: 0.0)
        let vector2 = Vector(x: -1.0, y: 1.0, z: 0.0)
        let crossVector = vector1.cross(vector2)
        XCTAssertEqual(crossVector.x, 0.0)
        XCTAssertEqual(crossVector.y, 0.0)
        XCTAssertEqual(crossVector.z, 2.0)
    }

    func testCrossProductDifferentAngles2() {
        let vector1 = Vector(x: 1.0, y: 1.0, z: 0.0)
        let vector2 = Vector(x: 0.0, y: 1.0, z: 0.0)
        let crossVector = vector1.cross(vector2)
        XCTAssertEqual(crossVector.x, 0.0)
        XCTAssertEqual(crossVector.y, 0.0)
        XCTAssertEqual(crossVector.z, sqrt(2.0) * sin(Double.pi/4.0), accuracy: Double.ulpOfOne)
    }

    func testMagnitudePositive() {
        let vector = Vector(r: 1024.6, theta1: 0.0, theta2: 0.0)
        XCTAssertEqual(vector.magnitude, 1024.6)
    }

    func testMagnitudeNegative() {
        let vector = Vector(r: -1024.6, theta1: 0.0, theta2: 0.0)
        XCTAssertEqual(vector.magnitude, 1024.6)
    }

    func testInvertPositive() {
        let vector = Vector(r: 10.0, theta1: 0.0, theta2: 0.0).inverted()
        XCTAssertEqual(vector.x, -10.0)
    }

    func testInvertNegative() {
        let vector = Vector(r: -10.0, theta1: 0.0, theta2: 0.0).inverted()
        XCTAssertEqual(vector.x, 10.0)
    }

    func testInvertedPositive() {
        let vector = Vector(r: 10.0, theta1: 0.0, theta2: 0.0)
        XCTAssertEqual(vector.inverted().x, -10.0)
    }

    func testInvertedNegative() {
        let vector = Vector(r: -10.0, theta1: 0.0, theta2: 0.0)
        XCTAssertEqual(vector.inverted().x, 10.0)
    }

    func testNormalizePositive() {
        let vector = Vector(r: 10.0, theta1: 0.0, theta2: 0.0).normalized()
        XCTAssertEqual(vector.x, 1.0)
    }

    func testNormalizeNegative() {
        let vector = Vector(r: -10.0, theta1: 0.0, theta2: 0.0).normalized()
        XCTAssertEqual(vector.x, -1.0)
    }

    func testNormalizedPositive() {
        let vector = Vector(r: 10.0, theta1: 0.0, theta2: 0.0)
        XCTAssertEqual(vector.normalized().x, 1.0)
    }

    func testNormalizedNegative() {
        let vector = Vector(r: -10.0, theta1: 0.0, theta2: 0.0)
        XCTAssertEqual(vector.normalized().x, -1.0)
    }

    func testVectorAddXYSimple() {
        let vector1 = Vector(x: 1.0, y: 1.0, z: 0.0)
        let vector2 = Vector(x: 1.0, y: 1.0, z: 0.0)
        let resultantVector = vector1 + vector2
        XCTAssertEqual(resultantVector.x, 2.0)
        XCTAssertEqual(resultantVector.y, 2.0)
        XCTAssertEqual(resultantVector.z, 0.0)
    }

    func testVectorAddXYComplicated() {
        let vector1 = Vector(x: 1.0, y: 1.0, z: 0.0)
        let vector2 = Vector(x: 0.7, y: 0.3, z: 0.0)
        let resultantVector = vector1 + vector2
        XCTAssertEqual(resultantVector.x, 1.7)
        XCTAssertEqual(resultantVector.y, 1.3)
        XCTAssertEqual(resultantVector.z, 0.0)
    }

    func testVectorAddXYZ() {
        let vector1 = Vector(x: 1.0, y: 1.0, z: 1.0)
        let vector2 = Vector(x: 0.7, y: 0.3, z: 0.5)
        let resultantVector = vector1 + vector2
        XCTAssertEqual(resultantVector.x, 1.7)
        XCTAssertEqual(resultantVector.y, 1.3)
        XCTAssertEqual(resultantVector.z, 1.5)
    }

    func testVectorSubtractXYSimple() {
        let vector1 = Vector(x: 1.0, y: 1.0, z: 0.0)
        let vector2 = Vector(x: 1.0, y: 1.0, z: 0.0)
        let resultantVector = vector1 - vector2
        XCTAssertEqual(resultantVector.x, 0.0)
        XCTAssertEqual(resultantVector.y, 0.0)
        XCTAssertEqual(resultantVector.z, 0.0)
    }

    func testVectorSubtractXYComplicated() {
        let vector1 = Vector(x: 1.0, y: 1.0, z: 0.0)
        let vector2 = Vector(x: 0.7, y: 0.3, z: 0.0)
        let resultantVector = vector1 - vector2
        XCTAssertEqual(resultantVector.x, 0.3, accuracy: Double.ulpOfOne)
        XCTAssertEqual(resultantVector.y, 0.7, accuracy: Double.ulpOfOne)
        XCTAssertEqual(resultantVector.z, 0.0, accuracy: Double.ulpOfOne)
    }

    func testVectorSubtractXYZ() {
        let vector1 = Vector(x: 1.0, y: 1.0, z: 1.0)
        let vector2 = Vector(x: 0.7, y: 0.3, z: 0.5)
        let resultantVector = vector1 - vector2
        XCTAssertEqual(resultantVector.x, 0.3, accuracy: Double.ulpOfOne)
        XCTAssertEqual(resultantVector.y, 0.7, accuracy: Double.ulpOfOne)
        XCTAssertEqual(resultantVector.z, 0.5, accuracy: Double.ulpOfOne)
    }

    func testVectorMultiplyByScalar() {
        let vector = Vector(x: 1.0, y: 2.0, z: 3.0)
        let resultantVector = vector * Double.pi
        XCTAssertEqual(resultantVector.x, Double.pi, accuracy: Double.ulpOfOne)
        XCTAssertEqual(resultantVector.y, 2.0 * Double.pi, accuracy: Double.ulpOfOne)
        XCTAssertEqual(resultantVector.z, 3.0 * Double.pi, accuracy: Double.ulpOfOne)
    }

    func testVectorEqualityBasic() {
        let vector1 = Vector(x: 1.0, y: 2.0, z: 3.0)
        let vector2 = Vector(x: 1.0, y: 2.0, z: 3.0)
        XCTAssert(vector1 == vector2)
    }

    func testVectorEqualityModified() {
        var vector1 = Vector(x: 1.0, y: 2.0, z: 2.0)
        let vector2 = Vector(x: 1.0, y: 2.0, z: 3.0)
        vector1.z = 3.0
        XCTAssert(vector1 == vector2)
    }
    
    //----------------------------------------------------------------------------------------------------------------------------------
    // MARK: - Time Tests
    //----------------------------------------------------------------------------------------------------------------------------------
    func testTimeToCreateOneMillionVectors() {
        self.measure {
            var vectors = [Vector]()
            for x in 0...99 {
                for y in 0...99 {
                    for z in 0...99 {
                        vectors.append(Vector(x: Double(x), y: Double(y), z: Double(z)))
                    }
                }
            }
        }
    }

}
