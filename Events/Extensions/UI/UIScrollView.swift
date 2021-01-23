//
//  UIScrollView.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import UIKit

public extension UIScrollView {

    private var _refreshControl: RefreshControl? { return refreshControl as? RefreshControl }

    func addRefreshControll(actionTarget: AnyObject?, action: Selector, replaceIfExist: Bool = false) {
        if !replaceIfExist && refreshControl != nil { return }
        refreshControl = RefreshControl(actionTarget: actionTarget, actionSelector: action)
    }

    func scrollToTopAndShowRunningRefreshControl(changeContentOffsetWithAnimation: Bool = false) {
        _refreshControl?.refreshActivityIndicatorView()
        guard   let refreshControl = refreshControl,
                contentOffset.y != -refreshControl.frame.height else { return }
        setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.height), animated: changeContentOffsetWithAnimation)
    }

    private var canStartRefreshing: Bool {
        guard let refreshControl = refreshControl, !refreshControl.isRefreshing else { return false }
        return true
    }

    func startRefreshing() {
        guard canStartRefreshing else { return }
        _refreshControl?.generateRefreshEvent()
    }

    func pullAndRefresh() {
        guard canStartRefreshing else { return }
        scrollToTopAndShowRunningRefreshControl(changeContentOffsetWithAnimation: true)
        _refreshControl?.generateRefreshEvent()
    }

    func endRefreshing(deadline: DispatchTime? = nil) { _refreshControl?.endRefreshing(deadline: deadline) }
}
