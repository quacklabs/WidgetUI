//
//  Text.swift
//  PartyWise
//
//  Created by Sprinthub on 18/02/2020.
//  Copyright © 2020 Sprinthub Mobile. All rights reserved.
//

import UIKit

@IBDesignable
public class Label: UILabel {
    
    public var content: String? {
        didSet {
            self.attributedText = self.content?.attributed
            self.draw(self.frame)
        }
    }
    
    @IBInspectable
    public var _font: UIFont = UIFont.systemFont(ofSize: 17) {
        didSet {
            self.font = Font.body.make(font: _font.fontName, withSize: _font.pointSize)
        }
    }
    public var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]() {
        didSet {
//            self.content?.a
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
    
    public convenience init(font: UIFont?, content: NSMutableAttributedString?, color: UIColor?) {
        self.init(frame: .zero)
        self.willSetConstraints()
        self.font = font?.dynamicSized() ?? UIFont.systemFont(ofSize: 14).dynamicSized()
        self.textColor = color ?? textColor
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        content?.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: content!.length))
        self.attributedText = content
        self.setNeedsDisplay()
    }
}
