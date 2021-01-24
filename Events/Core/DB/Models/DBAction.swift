//
//  DBAction.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/24/21.
//

import Foundation

enum DBAction<T> {
    case get(completion: (T?) -> Void)
    case set(value: T?, completion: () -> Void)
    case update(completion: (inout T?) -> Void)
}
