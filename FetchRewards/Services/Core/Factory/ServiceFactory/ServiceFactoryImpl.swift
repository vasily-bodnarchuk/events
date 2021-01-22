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
}

extension ServiceFactoryImpl: ServiceFactory {
    func createEventListService() -> EventListService {
        EventListServiceImpl(repository: EventListRepositoryImpl(networkService: networkService))
    }
}
