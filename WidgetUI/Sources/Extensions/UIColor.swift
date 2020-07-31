//
//  UIColor.swift
//  PartyWise
//
//  Created by Mark Boleigha on 31/07/2020.
//  Copyright © 2020 Sprinthub. MIT License
//

import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha:1)
    }
    
    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.substring(1)
        }
        
        var int = UInt32()
        var a, r, g, b:UInt32!
        let scanner = Scanner(string: hexWithoutSymbol)
        
        if scanner.scanHexInt32(&int) {
            switch(hexWithoutSymbol.length) {
                case 3: // RGB (12-bit)
                    a = 255
                    r = (int >> 8) * 17
                    g = (int >> 4 & 0xF)
                    b = (int & 0xF) * 17
                case 6: // RGB (24-bit)
                    a = 255
                    r = int >> 16
                    g = int >> 8 & 0xFF
                    b = int & 0xFF
                case 8: // ARGB (32-bit)
                    a = int >> 24
                    r = int >> 16 & 0xFF
                    g = int >> 8 & 0xFF
                    b = int & 0xFF
                default:
                    break
            }
            self.init(
                red: (CGFloat(r)/255),
                green: (CGFloat(g)/255),
                blue: (CGFloat(b)/255),
                alpha: alpha
            )
        } else {
            self.init(
                red: (CGFloat(255)/255),
                green: (CGFloat(255)/255),
                blue: (CGFloat(255)/255),
                alpha: alpha
            )
        }
    }
}
