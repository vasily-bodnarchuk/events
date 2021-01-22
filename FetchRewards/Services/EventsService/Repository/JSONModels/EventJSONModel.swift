//
//  EventJSONModel.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import Foundation

struct EventJSONModel: Decodable {
    let id: Int
    let title: String
    let venue: VenueJSONModel
    let datetime_utc: DecodableDate<DefaultDateFormatter>
}
