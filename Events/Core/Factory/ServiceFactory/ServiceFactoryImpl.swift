//
//  ServiceFactoryImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import Foundation

class ServiceFactoryImpl {
    lazy var configurationService: ConfigurationService = ConfigurationServiceImpl()
    lazy var networkService: NetworkService = NetworkServiceImpl(configurationService: configurationService)
    lazy var dbService: DBService = DBServiceImpl()
}

extension ServiceFactoryImpl: ServiceFactory {
    func createEventListService() -> EventListService {
        EventListServiceImpl(repository: EventListRepositoryImpl(networkService: networkService), dbService: dbService)
    }
    func createEventService(eventId: Int) -> EventService {
        EventServiceImpl(eventId: eventId, dbService: dbService)
    }
}
