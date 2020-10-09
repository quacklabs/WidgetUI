//
//  UIFont.swift
//  PartyWise
//
//  Created by Mark Boleigha on 31/07/2020.
//  Copyright © 2020 Sprinthub. MIT License
//

import UIKit

public enum Font {
    case heading
    case body
    
    public var lineHeight: CGFloat {
        switch self {
        case .heading:
            return 0.95
        case .body:
            return 13
        }
    }
    
    public var make: UIFont {
        return self.make()
    }
    
    public func make(font: String? = nil, withSize: CGFloat? = 14) -> UIFont {
        switch self {
        case .heading:
            return UIFont(name: font ?? "SF Pro Display", size: withSize ?? 36)!
        case .body:
            return UIFont(name: font ?? "SF Pro Text", size: withSize!)!
        }
    }
}


public extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var semibold: UIFont { return withWeight(.semibold) }
    var medium: UIFont { return withWeight(.medium) }
    var normal: UIFont { return withWeight(.regular)}
    var light: UIFont { return withWeight(.light) }
    var heavy: UIFont { return withWeight(.heavy) }
    var italic: UIFont { return withTraits(traits: .traitItalic)}
//    var extraBold: UIFont { return withTraits(traits: .tra)}
    
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

        traits[.weight] = weight

        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName

        let descriptor = UIFontDescriptor(fontAttributes: attributes)

        return UIFont(descriptor: descriptor, size: pointSize)
    }
    
    func withTraits(traits:UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0) //size 0 means keep the size as it is
    }
    
    var weight: UIFont.Weight {
        guard let weightNumber = traits[.weight] as? NSNumber else { return .regular }
        let weightRawValue = CGFloat(weightNumber.doubleValue)
        let weight = UIFont.Weight(rawValue: weightRawValue)
        return weight
    }
    
    private var traits: [UIFontDescriptor.TraitKey: Any] {
        return fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any]
            ?? [:]
    }
    
    func dynamicSized() -> UIFont {
        let currentFontName = self.fontName
        var calculatedFont: UIFont?
        let weight = self.weight
        let fontSize: CGFloat = self.pointSize
        
        switch UIDevice().model {
        case .iPhoneSE, .iPhone5, .iPhone5S, .iPhone5C,
             .iPod1, .iPod2, .iPod3, .iPod4, .iPod5, .iPhone4,
             .iPhone4S, .simulator, .unrecognized:
            calculatedFont = self
        case .iPhone6, .iPhone6S, .iPhone7, .iPhone8:
            calculatedFont = UIFont(name: currentFontName, size: fontSize * 1.08)!.withWeight(weight)
        case .iPhone6plus, .iPhone6Splus, .iPhone7plus,
             .iPhone8plus, .iPhoneX, .iPhoneXR, .iPhoneXS,
             .iPhoneXSMax:
            calculatedFont = UIFont(name: currentFontName, size: fontSize * 1.07)!.withWeight(weight)
        case .iPad2, .iPad3, .iPad4, .iPad5, .iPad6, .iPadAir, .iPadMini,
             .iPadPro2_12_9, .iPadAir2, .iPadMini2, .iPadMini3, .iPadMini4,
             .iPadPro9_7, .iPadPro10_5, .iPadPro12_9:
            calculatedFont =  UIFont(name: currentFontName, size: fontSize * 1.9)!.withWeight(weight)
        case .AppleTV, .AppleTV_4K:
            calculatedFont =  UIFont(name: currentFontName, size: fontSize * 3)!.withWeight(weight)
        }
        return calculatedFont!
    }
}
