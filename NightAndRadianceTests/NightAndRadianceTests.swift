//
//  NightAndRadianceTests.swift
//  NightAndRadianceTests
//
//  Created by Darin Stoker on 3/11/18.
//  Copyright © 2018 Darin Stoker. All rights reserved.
//

import XCTest
@testable import NightAndRadiance

class NightAndRadianceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // INITIALIZER TESTS
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
    
    // METHOD TESTS
    func testDotProductBasic() {
        let vector1 = Vector(x: 1.0, y: 1.0, z: 1.0)
        let vector2 = Vector(x: 0.0, y: 0.0, z: 0.0)
        let scalarDot = vector1.dot(vector2)
        XCTAssertEqual(scalarDot, 0.0, "Dot product failure.")
    }
    
    func testDotProductBasicSameVector() {
        let vector = Vector(x: 1.0, y: 1.0, z: 1.0)
        let scalarDot = vector.dot(vector)
        XCTAssertEqual(scalarDot, 3.0, "Dot product failure.")
    }
    
    func testDotProductBothNegative() {
        let vector1 = Vector(x: -1.0, y: -1.0, z: -1.0)
        let vector2 = Vector(x: -1.0, y: -1.0, z: -1.0)
        let scalarDot = vector1.dot(vector2)    // Don't want to use vector equals yet since it is untested.
        XCTAssertEqual(scalarDot, 3.0, "Dot product failure.")
    }
    
    func testDotProductNegativeAndPositive() {
        let vector1 = Vector(x: -1.0, y: -1.0, z: -1.0)
        let vector2 = Vector(x: 1.0, y: 1.0, z: 1.0)
        let scalarDot = vector1.dot(vector2)    // Don't want to use vector equals yet since it is untested.
        XCTAssertEqual(scalarDot, -3.0, "Dot product failure.")
    }
    
    // TIME TESTS
    func timeTestOneMillionVectors() {
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
