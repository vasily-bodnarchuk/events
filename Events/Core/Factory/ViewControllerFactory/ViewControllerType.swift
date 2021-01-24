//
//  ViewControllerType.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import Foundation

enum ViewControllerType {
    case coreLaunchingScreen
    case events(_ type: Subtypes.Event)
    case alert(type: Subtypes.Alert)

    class Subtypes {}
}

extension ViewControllerType.Subtypes {
    enum Event {
        case all
        case alreadyLoadedEvent(id: Int, title: String, location: String, date: String, imageUrl: URL)
    }

    enum Alert {
        case error(_ error: Error)
    }
}
