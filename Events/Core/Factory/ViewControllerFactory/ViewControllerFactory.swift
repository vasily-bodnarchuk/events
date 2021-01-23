//
//  ViewControllerFactory.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

protocol ViewControllerFactory {
    func create(_ viewController: ViewControllerType, completion: @escaping ((UIViewController) -> Void))
}

protocol ViewControllerFactoryDelegate: class {
    var serviceFactory: ServiceFactory { get }
    var router: Router { get }
    var viewBuilderFactory: ViewBuilderFactory { get }
}
