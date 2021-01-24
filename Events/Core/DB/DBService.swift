//
//  DBService.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/24/21.
//

import Foundation

protocol DBService: class {
    func action(value: DBValue)
}
