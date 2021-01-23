//
//  ViewBuilderFactory.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import Foundation

protocol ViewBuilderFactory: class {
    func createEventListTableViewBuilder(eventListService: EventListService) -> EventListTableViewBuilder
}
