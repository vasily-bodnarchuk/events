//
//  EventListService.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import Foundation

protocol EventListService: class {
    func load(searchBy keyword: String?, page: Int,
              completion: @escaping (Result<EventListJSONModel, Error>) -> Void)
}
