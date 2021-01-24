//
//  DefaultNavigationController.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/24/21.
//

import UIKit

class DefaultNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { _statusBarStyle }
    private var _statusBarStyle = UIStatusBarStyle.lightContent
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        _statusBarStyle = viewController.preferredStatusBarStyle
        setNeedsStatusBarAppearanceUpdate()
        super.pushViewController(viewController, animated: animated)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        if viewControllers.count > 1 {
            _statusBarStyle = viewControllers[viewControllers.count - 2].preferredStatusBarStyle
            setNeedsStatusBarAppearanceUpdate()
        }
        return super.popViewController(animated: animated)
    }
}
