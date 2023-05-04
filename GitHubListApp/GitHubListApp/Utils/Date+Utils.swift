//
//  Date+Utils.swift
//  GitHubListApp
//
//  Created by petrut alexandra on 27.04.2023.
//

let YearMonthDayFormatISO8601 = "yyyy-MM-dd"

import Foundation

extension Date {
    
    func formattedDateString(format: String) -> String {
         let formatter = DateFormatter()
         formatter.dateFormat = format
         return formatter.string(from: self)
     }
    
    static func getStartOfYear() -> Date {
        let now = Date()
        let calendar = Calendar.current
        return calendar.startOfDay(for: calendar.date(from: DateComponents(year: calendar.component(.year, from: now)))!)
    }
    
    func timeAgo() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
