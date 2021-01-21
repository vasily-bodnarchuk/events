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
    class Enums {}
}

extension Route.Enums {
    
    enum WhenPush {
        case always(type: ViewControllerType, completion: () -> Void, animated: Bool)
    }

    enum WhenPresent {
        case always(type: ViewControllerType, animated: Bool)
    }
}
