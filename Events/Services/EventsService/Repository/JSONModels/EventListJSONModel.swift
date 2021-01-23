//
//  EventListJSONModel.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import Foundation

struct EventListJSONModel: Decodable {
    let events: CompactDecodableArray<EventJSONModel>
    let meta: MetaJSONModel
}
