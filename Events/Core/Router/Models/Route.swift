//
//  Route.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

enum Route {
    case setRoot(type: ViewControllerType)
    case push(when: Enums.WhenPush)
    case present(when: Enums.WhenPresent)
    case back(when: Enums.WhenBack)
    class Enums {}
}

extension Route.Enums {

    enum WhenPush {
        case always(type: ViewControllerType, animated: Bool)
    }

    enum WhenPresent {
        case always(type: ViewControllerType, animated: Bool)
    }

    enum WhenBack {
        case always(route: BackRoutes)
    }

    enum BackRoutes {
        case popViewController(animated: Bool)
    }
}
