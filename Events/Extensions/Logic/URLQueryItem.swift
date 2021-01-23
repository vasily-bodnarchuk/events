//
//  URLQueryItem.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import Foundation

// MARK: - create [URLQueryItem] from [AnyHashable: Any] or [any]

extension URLQueryItem {
    private static var _bracketsString: String { "[]" }
    static func create(from values: [Any], with key: String) -> [URLQueryItem] {
        let _key = key.contains(_bracketsString) ? key : key + _bracketsString
        return values.compactMap { value -> URLQueryItem? in
            if value is [Any] || value is [AnyHashable: Any] { return nil }
            return URLQueryItem(name: _key, value: value as? String ?? "\(value)")
        }
    }

    static func create(from values: [AnyHashable: Any]) -> [URLQueryItem] {
        values.flatMap { element -> [URLQueryItem] in
            if element.value is [AnyHashable: Any] { return [] }
            let key = element.key as? String ?? "String"
            if let values = element.value as? [Any] { return URLQueryItem.create(from: values, with: key) }
            return [URLQueryItem(name: key, value: element.value as? String ?? "\(element.value)")]
        }
    }
}
