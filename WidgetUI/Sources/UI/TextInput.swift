//
//  TextInput.swift
//  WidgetUI
//
//  Created by Mark Boleigha on 31/07/2020.
//  Copyright © 2020 Sprinthub. MIT License
//

import UIKit

open class TextInput: UITextField {
    
    var borderWidth: CGFloat = 1.0
    var border: CALayer!
    var borderColor: UIColor = .lightGray
    
    lazy var errorLabel: Text = {
        let txt = Text(font: Font.body.make(withSize: 12), content: nil, color: UIColor.red)
        txt.sizeToFit()
        txt.willSetConstraints()
        return txt
    }()
    
    lazy var button: UIButton! = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: self.bounds.maxX-63, y: 14, width: 20, height: 20)
        button.clipsToBounds = true
        return button
    }()
    
    let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    
    enum IconPosition {
        case left
        case right
    }
    
    override public init(frame: CGRect) {
        super.init(frame: .zero)
        self.defaultSetup()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.defaultSetup()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func defaultSetup() {
        self.textColor = .lightGray
        self.font = Font.body.make(withSize: 18)
        self.addSubview(self.errorLabel)
        NSLayoutConstraint.activate([
            self.errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.errorLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
            self.errorLabel.heightAnchor.constraint(equalToConstant: 12),
        ])
    }
    
    func underline(with color: UIColor? = nil, lineWidth: CGFloat?) {
        self.borderStyle = .none
        self.border = CALayer()
        border.borderColor = color?.cgColor ??  borderColor.cgColor
        border.borderWidth = lineWidth ?? 1
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = 2
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func setIcon(_ image: UIImage, postion: IconPosition) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 14, height: 14))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: -80, y: 0, width: 15, height: 15))
        iconContainerView.addSubview(iconView)
        
        switch postion {
        case .right:
            rightView = iconContainerView
            rightViewMode = .always
        case .left:
            leftView = iconContainerView
            leftViewMode = .always
        }
    }
    
    func addViewPasswordButton() {
        self.button.imageView!.contentMode = .scaleAspectFit
        self.button.setImage(UIImage(named: "ic_reveal"), for: .normal)
        self.button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.rightView = self.button
        self.rightViewMode = .always
        
        self.button.addTarget(self, action: #selector(self.enablePasswordVisibilityToggle), for: .touchUpInside)
        self.button.layoutIfNeeded()
    }

    @objc func enablePasswordVisibilityToggle() {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            self.button.setImage(UIImage(named: "ic_reveal"), for: .normal)
        }else{
            self.button.setImage(UIImage(named: "ic_hide"), for: .normal)
        }
    }
    
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        super.rightViewRect(forBounds: self.button.frame)
    }
}
