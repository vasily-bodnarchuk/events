//
//  EventListRepository.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import Foundation

protocol EventListRepository: class {
    func getAll(completion: @escaping (Result<EventListJSONModel, Error>) -> Void) 
}
