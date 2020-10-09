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
            self.draw(self.frame)
        }
    }
    public var attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func draw(_ rect: CGRect) {
        super.drawText(in: rect)
    }
    
    convenience init(font: UIFont? = Font.body.make, content: NSMutableAttributedString?, color: UIColor? = .black) {
        self.init(frame: .zero)
        self.willSetConstraints()
        self.font = font!.dynamicSized()
        self.textColor = color
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        content?.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: content!.length))
        self.attributedText = content
        self.setNeedsDisplay()
    }
}
