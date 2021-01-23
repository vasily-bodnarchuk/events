//
//  ViewBuilderFactoryImpl.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import Foundation

class ViewBuilderFactoryImpl {}

extension ViewBuilderFactoryImpl: ViewBuilderFactory {
    func createEventListTableViewBuilder(eventListService: EventListService) -> EventListTableViewBuilder {
        EventListTableViewBuilderImpl(eventListService: eventListService)
    }
}
