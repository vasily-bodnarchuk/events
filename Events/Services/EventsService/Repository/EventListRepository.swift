//
//  EventListRepository.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import Foundation

protocol EventListRepository: class {
    func getAll(searchBy keyword: String?, completion: @escaping (Result<EventListJSONModel, Error>) -> Void)
}
