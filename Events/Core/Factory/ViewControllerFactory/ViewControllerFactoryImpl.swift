//
//  ViewControllerFactoryImpl.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

class ViewControllerFactoryImpl {
    private weak var delegate: ViewControllerFactoryDelegate!
    init(delegate: ViewControllerFactoryDelegate) {
        self.delegate = delegate
    }
}

extension ViewControllerFactoryImpl: ViewControllerFactory {
    func create(_ viewController: ViewControllerType, completion: @escaping ((UIViewController) -> Void)) {
        var newViewController: UIViewController!
        switch viewController {
        case .coreLaunchingScreen: newViewController = CoreLaunchingViewController()
        case .events(let type):
            switch type {
            case .all:
                let eventListService = delegate!.serviceFactory.createEventListService()
                let eventListTableViewBuilder = delegate!.viewBuilderFactory.createEventListTableViewBuilder(eventListService: eventListService)
                newViewController = EventsListViewController(eventListTableViewBuilder: eventListTableViewBuilder,
                                                             router: delegate.router)
            case let .alreadyLoadedEvent(id, title, location, date, imageUrl):
                newViewController = EventViewController()
                newViewController.title = title
            }
        }
        completion(newViewController)
    }
}
