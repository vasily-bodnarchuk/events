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

    class Subtypes {}
}

extension ViewControllerType.Subtypes {
    enum Event {
        case all
    }
}
