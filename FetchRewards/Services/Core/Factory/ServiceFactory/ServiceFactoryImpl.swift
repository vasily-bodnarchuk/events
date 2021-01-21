//
//  ServiceFactoryImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import Foundation

class ServiceFactoryImpl {

}


extension ServiceFactoryImpl: ServiceFactory {
    func createEventListService() -> EventListService {
        EventListServiceImpl(repository: EventListRepositoryImpl())
    }
}
