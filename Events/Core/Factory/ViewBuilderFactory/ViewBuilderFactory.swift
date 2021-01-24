//
//  ViewBuilderFactory.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import Foundation

protocol ViewBuilderFactory: class {
    func createEventTableViewBuilder(event: EventModel,
                                     delegate: EventTableViewBuilder.Delegate) -> EventTableViewBuilder
    func createEventListTableViewBuilder(eventListService: EventListService,
                                         delegate: EventListTableViewBuilder.Delegate) -> EventListTableViewBuilder
}
