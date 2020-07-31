//
//  Date.swift
//  PartyWise
//
//  Created by Mark Boleigha on 31/07/2020.
//  Copyright © 2020 Sprinthub. MIT License
//

import Foundation

extension Date {
    func daysFromToday() -> Int {
      return abs(Calendar.current.dateComponents([.day], from: self, to: Date()).day!)
    }
    
    func timeAgo() -> String {

        let secondsAgo = Int(Date().timeIntervalSince(self))

        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week

        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "Second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "Min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "Hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "Day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "Week"
        } else {
            quotient = secondsAgo / month
            unit = "Month"
        }
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
    }
    
    static func dateFromISOString(string: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        let date1 = dateFormatter.date(from: string)
        return date1
    }
}
