//
//  ViewBuilderFactoryImpl.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import Foundation

class ViewBuilderFactoryImpl {}

extension ViewBuilderFactoryImpl: ViewBuilderFactory {
    func createEventTableViewBuilder(event: EventModel, eventService: EventService,
                                     delegate: EventTableViewBuilder.Delegate) -> EventTableViewBuilder {
        EventTableViewBuilderImpl(event: event, eventService: eventService, delegate: delegate)
    }

    func createEventListTableViewBuilder(eventListService: EventListService,
                                         delegate: EventListTableViewBuilder.Delegate) -> EventListTableViewBuilder {
        EventListTableViewBuilderImpl(eventListService: eventListService, delegate: delegate)
    }
}
