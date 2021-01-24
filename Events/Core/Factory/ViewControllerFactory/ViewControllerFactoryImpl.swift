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
                let eventsListViewController = EventsListViewController(router: delegate.router)
                let eventListService = delegate!.serviceFactory.createEventListService()
                let tableViewBuilder = delegate!.viewBuilderFactory.createEventListTableViewBuilder(eventListService: eventListService,
                                                                                                    delegate: eventsListViewController)
                eventsListViewController.set(eventListTableViewBuilder: tableViewBuilder)
                newViewController = eventsListViewController
            case let .alreadyLoadedEvent(id, title, location, date, imageUrl):
                let eventViewController = EventViewController(router: delegate.router)
                let tableViewBuilder = delegate!.viewBuilderFactory.createEventTableViewBuilder(id: id,
                                                                                                title: title,
                                                                                                location: location,
                                                                                                date: date,
                                                                                                imageUrl: imageUrl,
                                                                                                delegate: eventViewController)
                eventViewController.set(eventTableViewBuilder: tableViewBuilder)
                newViewController = eventViewController
            }
        case .alert(let type):
            switch type {
            case .error(let error):
                let alertController = UIAlertController(title: "Error",
                                                        message: error.localizedDescription,
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                newViewController = alertController
            }
        }
        completion(newViewController)
    }
}
