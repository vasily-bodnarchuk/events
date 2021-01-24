//
//  EventModel.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/24/21.
//

import Foundation

struct EventModel {
    let id: Int
    let title: String
    let location: String
    let date: Date
    let visibleDate: String
    let imageUrl: URL
    let isFavorite: Bool
}
