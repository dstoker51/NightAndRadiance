//
//  PPMImage.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 2/18/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct PPMImage: CustomStringConvertible {
    var description: String {
        return toPPMString()
    }
    
    let width: Int
    let height: Int
    let raster: [Color]
    
    init(raster: [Color], imageHeightPixels: Int) {
        switch raster.count {
        case 0:
            self.width = 0
            self.height = 0
            self.raster = []
        default:
            switch imageHeightPixels {
            case ...0:
                self.width = 0
                self.height = 0
                self.raster = []
            default:
                self.width = Int(ceil(Double(raster.count) / Double(imageHeightPixels)))
                self.height = imageHeightPixels
                self.raster = raster + Array(repeating: Color(red: 0.0, green: 0.0, blue: 0.0), count: max(self.width * self.height - raster.count, 0))
            }
        }
    }
    
    init(raster: [Color], imageWidthPixels: Int) {
        switch raster.count {
        case 0:
            self.width = 0
            self.height = 0
            self.raster = []
        default:
            switch imageWidthPixels {
            case ...0:
                self.width = 0
                self.height = 0
                self.raster = []
            default:
                self.width = imageWidthPixels
                self.height = Int(ceil(Double(raster.count) / Double(imageWidthPixels)))
                self.raster = raster + Array(repeating: Color(red: 0.0, green: 0.0, blue: 0.0), count: max(self.width * self.height - raster.count, 0))
            }
        }
    }
    
    func toPPMString() -> String {
        var text = "P3\n\(width) \(height)\n255\n"
        for y in 0...height - 1 {
            var line = ""
            for x in 0...width - 1 {
                // Square root for gamma correction
                // TODO: Round instead?
                let red = Int(sqrt(raster[y * width + x].red) * 255.999)
                let green = Int(sqrt(raster[y * width + x].green) * 255.999)
                let blue = Int(sqrt(raster[y * width + x].blue) * 255.999)
                
                line.append(String(red) + " " + String(green) + " " + String(blue))
                if x != width - 1 {
                    line.append("\n")
                }
            }
            text.append(line + "\n")
        }
        return text
    }
    
    // TODO: How to report OS errors (permissions, insufficient space, etc)?
    func save(filename: String, filepath: String) -> URL? {
        let fileURL = URL(fileURLWithPath: filepath + "/" + filename).standardizedFileURL
        do {
            try self.toPPMString().write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Could not write \(filename) to \(filepath).")
            return nil
        }
        return fileURL
    }
}
