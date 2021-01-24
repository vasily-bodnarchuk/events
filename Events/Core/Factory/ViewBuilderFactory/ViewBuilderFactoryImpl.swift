//
//  ViewBuilderFactoryImpl.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import Foundation

class ViewBuilderFactoryImpl {}

extension ViewBuilderFactoryImpl: ViewBuilderFactory {
    func createEventTableViewBuilder(id: Int, title: String, location: String, date: String, imageUrl: URL) -> EventTableViewBuilder {
        EventTableViewBuilderImpl(id: id, title: title, location: location, date: date, imageUrl: imageUrl)
    }

    func createEventListTableViewBuilder(eventListService: EventListService,
                                         delegate: EventListTableViewBuilder.Delegate) -> EventListTableViewBuilder {
        EventListTableViewBuilderImpl(eventListService: eventListService, delegate: delegate)
    }
}
