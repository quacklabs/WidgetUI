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
    
    var lineHeight: CGFloat {
        switch self {
        case .heading:
            return 0.95
        case .body:
            return 13
        }
    }
    
    var make: UIFont {
        return self.make()
    }
    
    func make(font: String? = nil, withSize: CGFloat? = 14) -> UIFont {
        switch self {
        case .heading:
            return UIFont(name: font ?? "SF Pro Display", size: withSize ?? 36)!
        case .body:
            return UIFont(name: font ?? "SF Pro Text", size: withSize!)!
        }
    }
}


extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var semibold: UIFont { return withWeight(.semibold) }
    var medium: UIFont { return withWeight(.medium) }
    var normal: UIFont { return withWeight(.regular)}
    var light: UIFont { return withWeight(.light) }
    var heavy: UIFont { return withWeight(.heavy) }
    var italic: UIFont { return withTraits(traits: .traitItalic)}
    
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
}
