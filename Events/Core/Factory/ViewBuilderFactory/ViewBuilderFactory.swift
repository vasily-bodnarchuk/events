//
//  ViewBuilderFactory.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import Foundation

protocol ViewBuilderFactory: class {
    func createEventTableViewBuilder(id: Int, title: String, location: String, date: String, imageUrl: URL,
                                     delegate: EventTableViewBuilder.Delegate) -> EventTableViewBuilder
    func createEventListTableViewBuilder(eventListService: EventListService,
                                         delegate: EventListTableViewBuilder.Delegate) -> EventListTableViewBuilder
}
