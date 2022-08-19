//
//  Vector+PointTests.swift
//  
//
//  Created by Darin Stoker on 8/12/22.
//

import XCTest
@testable import NightAndRadiance

class Vector_PointTests: XCTestCase {

    //---------------------------------------------------------------------------------------------
    // MARK: - Initializer Tests
    //---------------------------------------------------------------------------------------------

    func testVectorFromPointsInitialization() {
        let point1 = Point3D(1.0, 1.0, 1.0)
        let point2 = Point3D(4.0, 4.0, 4.0)
        XCTAssertEqual(Vector4D(point1: point1, point2: point2), Vector4D(x: 3.0, y: 3.0, z: 3.0))
    }

    func testVectorFromPointInitialization() {
        let point1 = Point3D(1.0, 2.0, 3.0)
        XCTAssertEqual(Vector4D(point: point1), Vector4D(x: 1.0, y: 2.0, z: 3.0))
    }

    func testPointFromVectorInitialization() {
        let vector = Vector4D(x: 3.4, y: 4.5, z: 5.6)
        XCTAssertEqual(Point3D(vector: vector), Point3D(3.4, 4.5, 5.6))
    }
    
    //---------------------------------------------------------------------------------------------
    // MARK: - Vector Point Addition/Subtraction Tests
    //---------------------------------------------------------------------------------------------

    func testVectorPlusPoint() {
        let vector = Vector4D(x: 1.0, y: 2.0, z: 3.0)
        var resultantVector = vector + Point3D(2.0, 3.0, 4.0)
        XCTAssertEqual(resultantVector, Vector4D(x: 3.0, y: 5.0, z: 7.0))

        resultantVector = vector + Point3D(-2.0, -3.0, -4.0)
        XCTAssertEqual(resultantVector, Vector4D(x: -1.0, y: -1.0, z: -1.0))
    }

    func testVectorMinusPoint() {
        let vector = Vector4D(x: 1.0, y: 2.0, z: 3.0)
        var resultantVector = vector - Point3D(2.0, 3.0, 4.0)
        XCTAssertEqual(resultantVector, Vector4D(x: -1.0, y: -1.0, z: -1.0))

        resultantVector = vector - Point3D(-2.0, -3.0, -4.0)
        XCTAssertEqual(resultantVector, Vector4D(x: 3.0, y: 5.0, z: 7.0))
    }

    func testPointPlusVector() {
        let point = Point3D(1.0, 2.0, 3.0)
        var resultantPoint = point + Vector4D(x: 2.0, y: 3.0, z: 4.0)
        XCTAssertEqual(resultantPoint, Point3D(3.0, 5.0, 7.0))

        resultantPoint = point + Vector4D(x: -2.0, y: -3.0, z: -4.0)
        XCTAssertEqual(resultantPoint, Point3D(-1.0, -1.0, -1.0))
    }

    func testPointMinusVector() {
        let point = Point3D(1.0, 2.0, 3.0)
        var resultantPoint = point - Vector4D(x: 2.0, y: 3.0, z: 4.0)
        XCTAssertEqual(resultantPoint, Point3D(-1.0, -1.0, -1.0))

        resultantPoint = point - Vector4D(x: -2.0, y: -3.0, z: -4.0)
        XCTAssertEqual(resultantPoint, Point3D(3.0, 5.0, 7.0))
    }

    func testPointPlusPoint() {
        let point = Point3D(1.0, 2.0, 3.0)
        var resultantVector = point + Point3D(2.0, 3.0, 4.0)
        XCTAssertEqual(resultantVector, Vector4D(x: 3.0, y: 5.0, z: 7.0))

        resultantVector = point + Point3D(-2.0, -3.0, -4.0)
        XCTAssertEqual(resultantVector, Vector4D(x: -1.0, y: -1.0, z: -1.0))
    }

    func testPointMinusPoint() {
        let point = Point3D(1.0, 2.0, 3.0)
        var resultantVector = point - Point3D(2.0, 3.0, 4.0)
        XCTAssertEqual(resultantVector, Vector4D(x: -1.0, y: -1.0, z: -1.0))

        resultantVector = point - Point3D(-2.0, -3.0, -4.0)
        XCTAssertEqual(resultantVector, Vector4D(x: 3.0, y: 5.0, z: 7.0))
    }
}