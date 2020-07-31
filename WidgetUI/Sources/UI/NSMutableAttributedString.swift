//
//  NSMutableAttributedString.swift
//  PartyWise
//
//  Created by Mark Boleigha on 31/07/2020.
//  Copyright © 2020 Sprinthub. MIT License
//

import Foundation

extension NSMutableAttributedString {
    
    func withAttributes(attributes: [NSRange : [NSAttributedString.Key: AnyHashable]]) -> NSMutableAttributedString {
        attributes.forEach({
            let attribute = $0.value as [NSAttributedString.Key: AnyHashable]
            let range = $0.key
            
            attribute.forEach({ (key, value) in
                self.addAttribute(key, value: value, range: range)
            })
        })
        return self
    }
}
