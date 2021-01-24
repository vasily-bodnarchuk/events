//
//  DBServiceImpl.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/24/21.
//

import Foundation

class DBServiceImpl {
    private let queue = DispatchQueue(label: "DBServiceImpl", qos: .utility, attributes: .concurrent)
    private lazy var favoritedEventIds = { DBUserDefaultsValue<[Int]>(key: "favoritedEventIds") }()
}

extension DBServiceImpl: DBService {
    func action(value: DBValue) {
        queue.async { [weak self] in
            guard let self = self else { return }
            switch value {
            case .favoritedEvents(let action):
                switch action {
                case .get(let completion):
                    var ids = self.favoritedEventIds.syncGet()
                    if ids == nil {
                        self.favoritedEventIds.syncSet(value: [])
                        ids = []
                    }
                    completion(ids)
                case let .set(value, completion):
                    self.favoritedEventIds.syncSet(value: value)
                    completion()
                case .update(let completion):
                    var value = self.favoritedEventIds.syncGet()
                    completion(&value)
                    self.favoritedEventIds.syncSet(value: value)
                }
            }
        }
    }
}
