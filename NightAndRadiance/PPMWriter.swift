//
//  PPMWriter.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/18/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct PPMWriter {
    let filename: String
    let filepath: String
    let width: UInt32
    let height: UInt32
    
    init(filename: String, filepath: String, width: UInt32, height: UInt32) {
        self.filename = filename
        self.filepath = filepath
        self.width = width
        self.height = height
    }
    
    func write(raster: Array<Array<UInt8>>) {
        let fullPath = filepath + "/" + filename
        let fileURL = URL.init(fileURLWithPath: fullPath)
        
        var text = "P3 \(width) \(height) 255\n"
//        text.append(<#T##other: String##String#>)
        
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Could not write \(filename) to \(filepath).")
        }
    }
}
