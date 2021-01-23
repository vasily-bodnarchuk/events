//
//  MetaJSONModel.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import Foundation

struct MetaJSONModel: Decodable {
    let total: Int
    let page: Int
    let per_page: Int
}
