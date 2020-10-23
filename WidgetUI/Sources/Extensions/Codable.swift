//
//  Codable.swift
//  PartyWise
//
//  Created by Mark Boleigha on 31/07/2020.
//  Copyright © 2020 Sprinthub. MIT License
//

import Foundation

public extension Encodable {
    var dictionary: [String: Any]? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).map { $0 as? [String: Any] }!
    }
    
    var jsonData: Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .useDefaultKeys
        guard let data = try? encoder.encode(self) else { return nil }
        return data
    }
}

extension Dictionary {
    func object<T: Codable>(type: T.Type) throws -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.fragmentsAllowed, .prettyPrinted]) else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let obj = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        return obj
    }
    
    func objects<T: Codable>(type: T.Type) throws -> [T]? {
        var items = [T]()
        
        self.forEach({
            guard let data = try? JSONSerialization.data(withJSONObject: $0.value, options: [.fragmentsAllowed, .sortedKeys]) else {
                return
            }
    
            guard let obj = try? JSONDecoder().decode(T.self, from: data) else {
                return
            }
            items.append(obj)
        })
        return items
    }
}

