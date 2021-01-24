//
//  ReloadCompletable.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import Foundation

import UIKit

// MARK: - UITableView reloading functions

protocol ReloadCompletable: class { func reloadData() }

extension ReloadCompletable {
    func run(transaction closure: (() -> Void)?, completion: (() -> Void)?) {
        guard let closure = closure else { return }
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        closure()
        CATransaction.commit()
    }

    func run(transaction closure: (() -> Void)?, completion: ((Self) -> Void)?) {
        run(transaction: closure) { [weak self] in
            guard let self = self else { return }
            completion?(self)
        }
    }

    func reloadData(completion closure: ((Self) -> Void)?) {
        run(transaction: { [weak self] in self?.reloadData() }, completion: closure)
    }
}

// MARK: - UITableView reloading functions

extension ReloadCompletable where Self: UITableView {
    func reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation, completion closure: ((Self) -> Void)?) {
        run(transaction: { [weak self] in self?.reloadRows(at: indexPaths, with: animation) }, completion: closure)
    }

    func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation, completion closure: ((Self) -> Void)?) {
        run(transaction: { [weak self] in self?.reloadSections(sections, with: animation) }, completion: closure)
    }
}

extension UITableView: ReloadCompletable { }
