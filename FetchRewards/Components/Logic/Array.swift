//
//  Array.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import Foundation

// MARK: - [URLQueryItem] to [String: Any]

//extension Array where Element == URLQueryItem {
//    func toDictionary() -> [String: Any] {
//        var dictionary = [String: Any]()
//        for queryItem in self {
//            guard let value = queryItem.value?.toCorrectType() else { continue }
//            if queryItem.name.contains("[]") {
//                let key = queryItem.name.replacingOccurrences(of: "[]", with: "")
//                let array = dictionary[key] as? [Any] ?? []
//                dictionary[key] = array + [value]
//            } else {
//                dictionary[queryItem.name] = value
//            }
//        }
//        return dictionary
//    }
//}
