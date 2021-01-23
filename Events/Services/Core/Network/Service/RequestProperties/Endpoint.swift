//
//  Endpoint.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import Foundation

protocol EndpointComponent {
    var path: String { get }
}

enum Endpoint {
    case defaultApi(_ type: Enums.ApiVersion)
    class Enums {}

    func getPath(hostFor: (Endpoint) -> String) -> String {
        let host = hostFor(self)
        switch self {
        case .defaultApi(let type): return host + type.path
        }
    }
}

extension Endpoint.Enums {
    enum ApiVersion: EndpointComponent {
        case v2(_ type: ApiVersion2Paths)

        var path: String {
            switch self {
            case .v2(let type): return "/2" + type.path
            }
        }
    }
}

extension Endpoint.Enums {
    enum ApiVersion2Paths: EndpointComponent {
        case events

        var path: String {
            switch self {
            case .events: return "/events"
            }
        }
    }
}
