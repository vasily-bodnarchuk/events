//
//  DefaultDateFormatter.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import Foundation

class DefaultDateFormatter: StaticDateFormatterInterface {
    static var value: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")!
        return dateFormatter
    }()
}
