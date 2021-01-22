//
//  ServiceFactory.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import Foundation

protocol ServiceFactory: class {
    var networkService: NetworkService { get }
    func createEventListService() -> EventListService
}
