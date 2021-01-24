//
//  RouterImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

class RouterImpl {

    private(set) lazy var window: UIWindow = { UIWindow(frame: UIScreen.main.bounds) }()
    private weak var delegate: RouterDelegate!

    init(delegate: RouterDelegate) { self.delegate = delegate }

    private func setRoot(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    private func createViewController(_ viewController: ViewControllerType,
                                      properties: [RouteProperty],
                                      completion: @escaping (UIViewController) -> Void) {
        delegate.create(viewController) { newViewController in
            var resultViewController = newViewController
            for property in properties {
                switch property {
                case .embedIn(let type):
                    switch type {
                    case .defaultNavigationController:
                        resultViewController = DefaultNavigationController(rootViewController: resultViewController)
                    }
                }
            }
            completion(resultViewController)
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
        case .present(let when):
            switch when {
            case let .always(type, animated):
                createViewController(type, properties: properties) { [weak self] newViewController in
                    guard let self = self else { return }
                    guard let visibleViewController = self.getVisibleViewController() else { return }
                    visibleViewController.present(newViewController, animated: animated)
                }
            }
        case .push(let when):
            switch when {
            case let .always(type, animated):
                createViewController(type, properties: properties) { [weak self] newViewController in
                    guard let self = self else { return }
                    guard let visibleViewController = self.getVisibleViewController(),
                          let navigationController = visibleViewController as? UINavigationController ?? visibleViewController.navigationController else { return }
                    navigationController.pushViewController(newViewController, animated: animated)
                }
            }
        case .back(let when):
            switch when {
            case .always(let route):
                switch route {
                case .popViewController(let animated):
                    getVisibleViewController()?.navigationController?.popViewController(animated: animated)
                }
            }
        }
    }
}
