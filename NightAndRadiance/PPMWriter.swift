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
    let width: Int
    let height: Int
    
    init(filename: String, filepath: String, width: Int, height: Int) {
        self.filename = filename
        self.filepath = filepath
        self.width = abs(width)
        self.height = abs(height)
    }
    
    func write(raster: Array<Array<Int>>) {
        if raster.count != width * height {
            print("Raster must match width and height inputs.")
        }
        
        if raster[0].count != 3 {
            print("Raster must contain RGB as three separate values.")
        }
        
        let fullPath = filepath + "/" + filename
        let fileURL = URL.init(fileURLWithPath: fullPath)
        
        var text = "P3 \(width) \(height) 255\n"
        for y in 0...height - 1 {
            var line = ""
            for x in 0...width - 1 {
                line.append(String(raster[y * width + x][0]) + " " + String(raster[y * width + x][1]) + " " + String(raster[y * width + x][2]))
                if x != width - 1 {
                    line.append(" ")
                }
            }
            text.append(line + "\n")
        }
        
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Could not write \(filename) to \(filepath).")
        }
    }
}
