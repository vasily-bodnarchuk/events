//
//  URL.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import Foundation

// MARK: - URL query to [URLQueryItem]

extension URL {
    func toQueryItems() -> [URLQueryItem]? { URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems }
}
