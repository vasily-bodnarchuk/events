//
//  CoreImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

class CoreImpl {
    fileprivate var router: Router!
    fileprivate var factory: Factory!

    class func create() -> Core {
        let core = CoreImpl()
        let router = RouterImpl(delegate: core)
        core.router = router
        core.factory = FactoryImpl.create(router: router)
        return core
    }

    private init() { }
}

extension CoreImpl: Core {
    func launch() {
       // router.route(to: .setRoot(type: .coreLaunchingScreen))
        router.route(to: .setRoot(type: .events(.all)),
                     properties: [.embedIn(type: .defaultNavigationController)])
    }
}

extension CoreImpl: RouterDelegate {
    func create(_ viewController: ViewControllerType, completion: @escaping ((UIViewController) -> Void)) {
        factory.create(viewController, completion: completion)
    }
}
