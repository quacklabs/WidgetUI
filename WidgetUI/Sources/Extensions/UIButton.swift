//
//  UIButton.swift
//  PartyWise
//
//  Created by Mark Boleigha on 31/07/2020.
//  Copyright © 2020 Sprinthub. MIT License
//

import UIKit

public extension UIButton {
    
    var disabled: UIButton {
        self.isEnabled = false
        return self
    }
    
    override var isEnabled: Bool {
        didSet {
            self.backgroundColor =  self.backgroundColor?.withAlphaComponent(isEnabled ? 1.0 : 0.5)
        }
    }
    
    func resetColor(withOpacity: CGFloat? = 0.3) {
        if self.isEnabled == false {
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(withOpacity!)
        }
    }
}
