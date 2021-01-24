//
//  DBUserDefaultsValue.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/24/21.
//

import Foundation

class DBUserDefaultsValue<T> {

    private let semaphore = DispatchSemaphore(value: 1)
    private var accessKey: String
    private var cachedValue: T?

    init(key: String) { accessKey = key }
    deinit { semaphore.signal() }
    func syncGet() -> T? {
        semaphore.wait(); defer { semaphore.signal() }
        if cachedValue != nil { return cachedValue }

        UserDefaults.standard.string(forKey: accessKey)
        guard   let value = UserDefaults.standard.value(forKey: accessKey) as? T else {
                semaphore.signal()
                return nil
        }
        cachedValue = value
        return cachedValue
    }

    func syncSet(value: T?) {
        semaphore.wait(); defer { semaphore.signal() }
        UserDefaults.standard.set(value, forKey: accessKey)
        cachedValue = value
    }
}
