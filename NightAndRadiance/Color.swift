//
//  Color.swift
//  NightAndRadiance
//
//  Created by Darin Stoker on 3/1/19.
//  Copyright © 2019 Darin Stoker. All rights reserved.
//

import Foundation

struct Color: Hashable {
    static let min = 0.0
    static let max = 255.0
    var red:   Double
    var green: Double
    var blue:  Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(red: Int, green: Int, blue: Int) {
        self.init(red: Double(red), green: Double(green), blue: Double(blue))
    }
    
    init(color: Color) {
        self.init(red: color.red, green: color.green, blue: color.blue)
    }
    
    static func +(lhs: Color, rhs: Color) -> Color {
        return Color(red: lhs.red + rhs.red, green: lhs.green + rhs.green, blue: lhs.blue + rhs.blue)
    }
    
    static func -(lhs: Color, rhs: Color) -> Color {
        return Color(red: lhs.red - rhs.red, green: lhs.green - rhs.green, blue: lhs.blue - rhs.blue)
    }
    
    static func *(color: Color, scalingFactor: Double) -> Color {
        return Color(red: color.red * scalingFactor, green: color.green * scalingFactor, blue: color.blue * scalingFactor)
    }
    
    static func /(color: Color, denominator: Double) -> Color {
        return color * (1.0 / denominator)
    }
    
    mutating func clamped() -> Color {
        if red < Color.min {
            red = Color.min
        }
        if red > Color.max {
            red = Color.max
        }
        if green < Color.min {
            green = Color.min
        }
        if green > Color.max {
            green = Color.max
        }
        if blue < Color.min {
            blue = Color.min
        }
        if blue > Color.max {
            blue = Color.max
        }
        return Color(red: red, green: green, blue: blue)
    }
}
