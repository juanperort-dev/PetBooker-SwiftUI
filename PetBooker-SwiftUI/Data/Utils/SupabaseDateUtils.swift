//
//  SupabaseDateUtils.swift
//  PetBooker-SwiftUI
//
//  Created by Juan José Perálvarez Ortiz on 7/11/25.
//

import Foundation

enum SupabaseDateUtils {
    
    static let databaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    static func date(from dateString: String?) -> Date? {
        guard let dateString = dateString else {
            return nil
        }
        return databaseDateFormatter.date(from: dateString)
    }
}
