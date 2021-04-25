//
//  Text.swift
//  PartyWise
//
//  Created by Sprinthub on 18/02/2020.
//  Copyright © 2020 Sprinthub Mobile. All rights reserved.
//

import UIKit

@IBDesignable
public class Text: UILabel {
    
    public var content: NSMutableAttributedString? {
        didSet {
            self.attributedText = self.content
            self.draw(self.frame)
        }
    }
    


    @IBInspectable
    public var _font: UIFont = UIFont.systemFont(ofSize: 17) {
        didSet {
            self.font = Font.body.make(font: _font.fontName, withSize: _font.pointSize)
        }
    }
    
    @IBInspectable
    public var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]() {
        didSet {
            //TODO: Make text re-render in IB or SWiftUI Accordingly
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func draw(_ rect: CGRect) {
        super.drawText(in: rect)
    }
    
    public convenience init(font: UIFont?, content: NSMutableAttributedString?, color: UIColor? = .black) {
        self.init(frame: .zero)
        self.willSetConstraints()
        self.font = self.overrideFontSize(font: font!)
        self.textColor = color
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        self.content = content
        self.write() // show text with attribuutes applied
        self.setNeedsDisplay()
    }

    func write() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        content?.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: content!.length))
        self.text = nil
        self.attributedText = content
        self.setNeedsDisplay()
        self.layoutIfNeeded()
    }

    func overrideFontSize(font: UIFont) -> UIFont {
        let currentFontName = font.fontName
        var calculatedFont: UIFont?
        let weight = font.weight
        let fontSize: CGFloat = font.pointSize
        
        switch UIDevice().model {
        case .iPhoneSE, .iPhone5, .iPhone5S, .iPhone5C,
             .iPod1, .iPod2, .iPod3, .iPod4, .iPod5, .iPhone4,
             .iPhone4S:
            calculatedFont = font
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
        case .simulator, .unrecognized:
           calculatedFont = font
        }
        return calculatedFont!
    }
}
