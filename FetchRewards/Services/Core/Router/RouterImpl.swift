//
//  RouterImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

class RouterImpl {
    
    private lazy var window: UIWindow = {
        UIWindow(frame: UIScreen.main.bounds)
    }()
    
    private weak var delegate: RouterDelegate!
    
    init(delegate: RouterDelegate) {
        self.delegate = delegate
    }
    
    private func setRoot(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    private func createViewController(_ viewController: ViewControllerType,
                                      properties: [RouteProperty],
                                      completion: @escaping (UIViewController) -> Void) {
        delegate.create(viewController) { newViewController in
            for property in properties {
                switch property {
                case .embedIn(let type):
                    switch type {
                    case .defaultNavigationController:
                        completion(UINavigationController(rootViewController: newViewController))
                    }
                }
            }
        }
    }
}

extension RouterImpl: Router {
    func route(to route: Route, properties: [RouteProperty]) {
        switch route {
        case .setRoot(let type):
            createViewController(type, properties: properties) { [weak self] newViewController  in
                self?.setRoot(newViewController)
            }
        case .present(let when): break
        case .push(let when): break
        }
    }
}
