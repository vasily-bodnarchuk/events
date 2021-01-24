//
//  ServiceFactory.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import Foundation

protocol ServiceFactory: class {
    var networkService: NetworkService { get }
    var dbService: DBService { get }
    func createEventListService() -> EventListService
    func createEventService(eventId: Int) -> EventService
}
