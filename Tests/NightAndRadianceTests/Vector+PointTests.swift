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
        let point1 = Point(1.0, 1.0, 1.0)
        let point2 = Point(4.0, 4.0, 4.0)
        XCTAssertEqual(Vector(point1: point1, point2: point2), Vector(x: 3.0, y: 3.0, z: 3.0))
    }

    func testVectorFromPointInitialization() {
        let point1 = Point(1.0, 2.0, 3.0)
        XCTAssertEqual(Vector(point: point1), Vector(x: 1.0, y: 2.0, z: 3.0))
    }

    func testPointFromVectorInitialization() {
        let vector = Vector(x: 3.4, y: 4.5, z: 5.6)
        XCTAssertEqual(Point(vector: vector), Point(3.4, 4.5, 5.6))
    }
    
    //---------------------------------------------------------------------------------------------
    // MARK: - Vector Point Addition/Subtraction Tests
    //---------------------------------------------------------------------------------------------

    func testVectorPlusPoint() {
        let vector = Vector(x: 1.0, y: 2.0, z: 3.0)
        var resultantVector = vector + Point(2.0, 3.0, 4.0)
        XCTAssertEqual(resultantVector, Vector(x: 3.0, y: 5.0, z: 7.0))

        resultantVector = vector + Point(-2.0, -3.0, -4.0)
        XCTAssertEqual(resultantVector, Vector(x: -1.0, y: -1.0, z: -1.0))
    }

    func testVectorMinusPoint() {
        let vector = Vector(x: 1.0, y: 2.0, z: 3.0)
        var resultantVector = vector - Point(2.0, 3.0, 4.0)
        XCTAssertEqual(resultantVector, Vector(x: -1.0, y: -1.0, z: -1.0))

        resultantVector = vector - Point(-2.0, -3.0, -4.0)
        XCTAssertEqual(resultantVector, Vector(x: 3.0, y: 5.0, z: 7.0))
    }

    func testPointPlusVector() {
        let point = Point(1.0, 2.0, 3.0)
        var resultantPoint = point + Vector(x: 2.0, y: 3.0, z: 4.0)
        XCTAssertEqual(resultantPoint, Point(3.0, 5.0, 7.0))

        resultantPoint = point + Vector(x: -2.0, y: -3.0, z: -4.0)
        XCTAssertEqual(resultantPoint, Point(-1.0, -1.0, -1.0))
    }

    func testPointMinusVector() {
        let point = Point(1.0, 2.0, 3.0)
        var resultantPoint = point - Vector(x: 2.0, y: 3.0, z: 4.0)
        XCTAssertEqual(resultantPoint, Point(-1.0, -1.0, -1.0))

        resultantPoint = point - Vector(x: -2.0, y: -3.0, z: -4.0)
        XCTAssertEqual(resultantPoint, Point(3.0, 5.0, 7.0))
    }

    func testPointPlusPoint() {
        let point = Point(1.0, 2.0, 3.0)
        var resultantVector = point + Point(2.0, 3.0, 4.0)
        XCTAssertEqual(resultantVector, Vector(x: 3.0, y: 5.0, z: 7.0))

        resultantVector = point + Point(-2.0, -3.0, -4.0)
        XCTAssertEqual(resultantVector, Vector(x: -1.0, y: -1.0, z: -1.0))
    }

    func testPointMinusPoint() {
        let point = Point(1.0, 2.0, 3.0)
        var resultantVector = point - Point(2.0, 3.0, 4.0)
        XCTAssertEqual(resultantVector, Vector(x: -1.0, y: -1.0, z: -1.0))

        resultantVector = point - Point(-2.0, -3.0, -4.0)
        XCTAssertEqual(resultantVector, Vector(x: 3.0, y: 5.0, z: 7.0))
    }
}
