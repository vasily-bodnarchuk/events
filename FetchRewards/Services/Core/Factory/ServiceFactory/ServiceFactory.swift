//
//  ServiceFactory.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import Foundation

protocol ServiceFactory: class {
    func createEventListService() -> EventListService
}
