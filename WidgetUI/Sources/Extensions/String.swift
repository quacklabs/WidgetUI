//
//  String.swift
//  PartyWise
//
//  Created by Mark Boleigha on 31/07/2020.
//  Copyright © 2020 Sprinthub. MIT License
//

import Foundation

public extension String {
    var isBackspace: Bool {
      let char = self.cString(using: String.Encoding.utf8)!
      return strcmp(char, "\\b") == -8
    }
    
    var length: Int {
        return self.count
    }

    func substring(_ from: Int, _ length: Int? = nil) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return (length != nil && self.length > 0) ? String(self[fromIndex ..< self.index(fromIndex, offsetBy: length!)]) : String(self[fromIndex...])
    }
    
    var htmlencoded:String {
        let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
        let unreservedCharset = NSCharacterSet(charactersIn: unreservedChars)
        let encodedString = self.addingPercentEncoding(withAllowedCharacters: unreservedCharset as CharacterSet)
        return encodedString ?? self
    }
    
    var attributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }
    
    var currencySymbol: String? {
        let locale = Locale.init(identifier: "en_NG")
        return locale.currencySymbol! + self
    }
    
    var currency: String {
        // removing all characters from string before formatting
        let locale = Locale.init(identifier: "en_NG")
        
        let stringWithoutSymbolOrComma = self.replacingOccurrences(of: locale.currencySymbol!, with: "").replacingOccurrences(of: ",", with: "")
        
        let styler = NumberFormatter()
        styler.minimumFractionDigits = 0
        styler.maximumFractionDigits = 2
        styler.locale = locale
        styler.numberStyle = .currency
        styler.currencyGroupingSeparator = ","
        styler.currencyDecimalSeparator = "."
        styler.currencySymbol = locale.currencySymbol

        if let result = NumberFormatter().number(from: stringWithoutSymbolOrComma) {
            return styler.string(from: result)!
        }

        return self
    }
    
    var toDouble: Double {
        // removing all characters from string before formatting
        let locale = Locale.init(identifier: "en_NG")
        let stringWithoutSymbolOrComma = self.replacingOccurrences(of: locale.currencySymbol!, with: "").replacingOccurrences(of: ",", with: "")
        return Double(stringWithoutSymbolOrComma)!
    }
    
    func formatWithPattern(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pureNumber)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    func regex (pattern: String) -> [String] {
      do {
        let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        let nsstr = self as NSString
        let all = NSRange(location: 0, length: nsstr.length)
        var matches : [String] = [String]()
        regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
          (result : NSTextCheckingResult?, _, _) in
          if let r = result {
            let result = nsstr.substring(with: r.range) as String
            matches.append(result)
          }
        }
        return matches
      } catch {
        return [String]()
      }
    }

    func matches(pattern: String) -> Bool {
      do {
        let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        let nsstr = self as NSString
        let all = NSRange(location: 0, length: nsstr.length)
        var matches : [String] = [String]()
        regex.enumerateMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: all) {
          (result : NSTextCheckingResult?, _, _) in
          if let r = result {
            let result = nsstr.substring(with: r.range) as String
            matches.append(result)
          }
        }
        return (matches.count > 0) ? true : false
      } catch {
        return false
      }
    }
}
