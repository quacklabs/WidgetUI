//
//  Array.swift
//  PartyWise
//
//  Created by Mark Boleigha on 31/07/2020.
//  Copyright © 2020 Sprinthub. MIT License
//

import Foundation

public extension Array {
    public mutating func appendDistinct<S>(contentsOf newElements: S, where condition:@escaping (Element, Element) -> Bool) where S : Sequence, Element == S.Element {
        newElements.forEach { (item) in
            if !(self.contains(where: { (selfItem) -> Bool in
                return !condition(selfItem, item)
            })) {
                self.append(item)
            }
        }
    }
}

public extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var set = Set<Element>()
        var filteredArray = Array<Element>()
        for item in self {
           if set.insert(item).inserted {
              filteredArray.append(item)
           }
        }
        return filteredArray
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
