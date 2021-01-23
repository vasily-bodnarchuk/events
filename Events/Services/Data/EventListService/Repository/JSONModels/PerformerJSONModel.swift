//
//  PerformerJSONModel.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import Foundation

struct PerformerJSONModel: Decodable {
    let id: Int
    let name: String
    let image: URL
}
