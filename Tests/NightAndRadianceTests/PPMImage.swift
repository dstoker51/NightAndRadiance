//
//  PPMImageTests.swift
//  
//
//  Created by Darin Stoker on 8/12/22.
//

import XCTest
@testable import NightAndRadiance

class PPMImageTests: XCTestCase {
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
