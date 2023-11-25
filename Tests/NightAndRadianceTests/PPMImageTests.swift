//
//  PPMImageTests.swift
//  
//
//  Created by Darin Stoker on 8/12/22.
//

import XCTest
@testable import NightAndRadiance

class PPMImageTests: XCTestCase {
    func testInitHeight() {
        var image = PPMImage(raster: [], imageHeightPixels: 0)
        XCTAssertEqual(image.width, 0)
        XCTAssertEqual(image.height, 0)
        XCTAssertEqual(image.raster.count, image.width * image.height)
        
        image = PPMImage(raster: [Color(red: 100.0, green: 100.0, blue: 100.0)], imageHeightPixels: 0)
        XCTAssertEqual(image.width, 0)
        XCTAssertEqual(image.height, 0)
        XCTAssertEqual(image.raster.count, image.width * image.height)
        
        image = PPMImage(raster: Array.init(repeating: Color(red: 100.0, green: 100.0, blue: 100.0), count: 100), imageHeightPixels: 10)
        XCTAssertEqual(image.width, 10)
        XCTAssertEqual(image.height, 10)
        XCTAssertEqual(image.raster.count, image.width * image.height)
        
        image = PPMImage(raster: Array.init(repeating: Color(red: 100.0, green: 100.0, blue: 100.0), count: 101), imageHeightPixels: 10)
        XCTAssertEqual(image.width, 11)
        XCTAssertEqual(image.height, 10)
        XCTAssertEqual(image.raster.count, image.width * image.height)
        
        image = PPMImage(raster: Array.init(repeating: Color(red: 100.0, green: 100.0, blue: 100.0), count: 10), imageHeightPixels: 11)
        XCTAssertEqual(image.width, 1)
        XCTAssertEqual(image.height, 11)
        XCTAssertEqual(image.raster.count, image.width * image.height)
    }
    
    func testInitWidth() {
        var image = PPMImage(raster: [], imageWidthPixels: 0)
        XCTAssertEqual(image.width, 0)
        XCTAssertEqual(image.height, 0)
        XCTAssertEqual(image.raster.count, image.width * image.height)
        
        image = PPMImage(raster: [Color(red: 100.0, green: 100.0, blue: 100.0)], imageWidthPixels: 0)
        XCTAssertEqual(image.width, 0)
        XCTAssertEqual(image.height, 0)
        XCTAssertEqual(image.raster.count, image.width * image.height)
        
        image = PPMImage(raster: Array.init(repeating: Color(red: 100.0, green: 100.0, blue: 100.0), count: 100), imageWidthPixels: 10)
        XCTAssertEqual(image.width, 10)
        XCTAssertEqual(image.height, 10)
        XCTAssertEqual(image.raster.count, image.width * image.height)
        
        image = PPMImage(raster: Array.init(repeating: Color(red: 100.0, green: 100.0, blue: 100.0), count: 101), imageWidthPixels: 10)
        XCTAssertEqual(image.width, 10)
        XCTAssertEqual(image.height, 11)
        XCTAssertEqual(image.raster.count, image.width * image.height)
        
        image = PPMImage(raster: Array.init(repeating: Color(red: 100.0, green: 100.0, blue: 100.0), count: 10), imageWidthPixels: 11)
        XCTAssertEqual(image.width, 11)
        XCTAssertEqual(image.height, 1)
        XCTAssertEqual(image.raster.count, image.width * image.height)
    }
    
    func testSave() {
        var raster: Array<Color> = []
        let imageWidth = 1000
        let imageHeight = 1000
        func testPPMGradient() {
            for j in stride(from: imageHeight, to: 0, by: -1) {
                for i in stride(from: 0, to: imageWidth, by: 1) {
                    raster.append(Color(red: Double(i)/Double(imageWidth), green: Double(j)/Double(imageHeight), blue: 0.25))
                }
            }
            
            let image = PPMImage(raster: raster, imageHeightPixels: imageHeight)
            XCTAssertNotNil(image.save(filename: "test.ppm", filepath: "/Users/dstoker/Downloads"))
            
            // TODO: Add a way to save the raster using Xcode asset functionality like in CriRaster at work
        }
    }
}
