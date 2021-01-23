//
//  RouteProperty.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import UIKit

enum RouteProperty {
    case embedIn(type: Enums.ParentController)

    class Enums {}
}

extension RouteProperty.Enums {
    enum ParentController {
        case defaultNavigationController
    }
}
