//
//  Dictionary.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import Foundation

// MARK: - [AnyHashable: Any] to [URLQueryItem]

extension Dictionary where Value: Any {
   func toURLQueryItems() -> [URLQueryItem] { URLQueryItem.create(from: self) }
}
