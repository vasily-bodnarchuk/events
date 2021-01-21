//
//  FactoryImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

class FactoryImpl {
    private var viewControllerFactory: ViewControllerFactory!
    private var _serviceFactory: ServiceFactory!
    
    class func create() -> Factory {
        let factory = FactoryImpl()
        factory._serviceFactory = ServiceFactoryImpl()
        factory.viewControllerFactory = ViewControllerFactoryImpl(delegate: factory)
        return factory
    }
}

extension FactoryImpl: Factory {
    func create(_ viewController: ViewControllerType, completion: @escaping ((UIViewController) -> Void)) {
        viewControllerFactory.create(viewController, completion: completion)
    }
}

extension FactoryImpl: ViewControllerFactoryDelegate {
    var serviceFactory: ServiceFactory { _serviceFactory }
}
