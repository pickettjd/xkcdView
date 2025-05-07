//
//  DateExtension.swift
//  xkcdView
//
//  Created by Jeff Pickett on 5/7/25.
//

import Foundation


extension Date {
    static func createDateStringFromComponents(year: String,
                                               month: String,
                                               day: String) -> String {
        guard let date = Calendar.current.date(from: DateComponents(calendar: Calendar.current,
                                                                    year: Int(year),
                                                                    month: Int(month),
                                                                    day: Int(day))) else {
            return "Unkown Date"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
}
