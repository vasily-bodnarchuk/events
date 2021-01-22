//
//  DecodableDate.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import Foundation

protocol StaticDateFormatterInterface {
    static var value: DateFormatter { get }
}

enum DecodableDate<Formatter> where Formatter: StaticDateFormatterInterface {
    case value(Date)
    case error(DecodingError)
    
    var value: Date? {
        switch self {
        case .value(let value): return value
        case .error: return nil
        }
    }
    
    var error: DecodingError? {
        switch self {
        case .value: return nil
        case .error(let error): return error
        }
    }
    
    enum DecodingError: Error {
        case wrongFormat(source: String, dateFormatter: DateFormatter)
        case decoding(error: Error)
    }
}

extension DecodableDate: Decodable {
    func createDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }
    
    init(from decoder: Decoder) throws {
        do {
            let dateString = try decoder.singleValueContainer().decode(String.self)
            guard let date = Formatter.value.date(from: dateString) else {
                self = .error(DecodingError.wrongFormat(source: dateString, dateFormatter: Formatter.value))
                return
            }
            self = .value(date)
        } catch let err {
            self = .error(.decoding(error: err))
        }
    }
}

