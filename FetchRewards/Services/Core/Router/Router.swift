//
//  Router.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

protocol Router: class {
    func route(to route: Route, properties: [RouteProperty])
}

extension Router {
    func route(to route: Route) { self.route(to: route, properties: []) }
}

protocol RouterDelegate: class {
    func create(_ viewController: ViewControllerType, completion: @escaping ((UIViewController) -> Void))
}
