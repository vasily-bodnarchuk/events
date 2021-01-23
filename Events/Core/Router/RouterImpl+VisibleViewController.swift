//
//  RouterImpl+VisibleViewController.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

extension RouterImpl {
    func getVisibleViewController() -> UIViewController? {
        if let rootViewController: UIViewController = window.rootViewController {
            return getVisibleViewControllerFrom(viewController: rootViewController)
        }
        return nil
    }

    private func getVisibleViewControllerFrom(viewController: UIViewController) -> UIViewController {
        switch viewController {
        case is UINavigationController:
            let navigationController = viewController as! UINavigationController
            return getVisibleViewControllerFrom(viewController: navigationController.visibleViewController!)

        case is UITabBarController:
            let tabBarController = viewController as! UITabBarController
            return getVisibleViewControllerFrom(viewController: tabBarController.selectedViewController!)

        default:
            if let presentedViewController = viewController.presentedViewController {
                return getVisibleViewControllerFrom(viewController: presentedViewController)
            } else {
                return viewController
            }
        }
    }
}
