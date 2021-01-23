//
//  FactoryImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

class FactoryImpl {
    private weak var _router: Router!
    private var viewControllerFactory: ViewControllerFactory!
    private var _serviceFactory: ServiceFactory!
    private var _viewBuilderFactory: ViewBuilderFactory!

    class func create(router: Router) -> Factory {
        let factory = FactoryImpl()
        factory._serviceFactory = ServiceFactoryImpl()
        factory.viewControllerFactory = ViewControllerFactoryImpl(delegate: factory)
        factory._viewBuilderFactory = ViewBuilderFactoryImpl()
        factory._router = router
        return factory
    }
}

extension FactoryImpl: Factory {
    func create(_ viewController: ViewControllerType, completion: @escaping ((UIViewController) -> Void)) {
        viewControllerFactory.create(viewController, completion: completion)
    }
}

extension FactoryImpl: ViewControllerFactoryDelegate {
    var router: Router { _router }
    var serviceFactory: ServiceFactory { _serviceFactory }
    var viewBuilderFactory: ViewBuilderFactory { _viewBuilderFactory }
}
