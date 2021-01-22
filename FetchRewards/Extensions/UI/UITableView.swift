//
//  UITableView.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/21/21.
//

import UIKit

// MARK: - Easy reusing cells mechanism

extension UITableView {
    typealias CellType = UITableViewCell
    typealias IdentifiableCell = CellType & Identifiable

    func register<T: IdentifiableCell>(class: T.Type) { register(T.self, forCellReuseIdentifier: T.identifier) }

    func register(classes: [Identifiable.Type]) {
        classes.forEach { register($0.self, forCellReuseIdentifier: $0.identifier) }
    }

    func dequeueReusableCell<T: IdentifiableCell>(class: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }

    func dequeueReusableCell<T: IdentifiableCell>(forceUnwrap aClass: T.Type, for indexPath: IndexPath, initital closure: ((T) -> Void)?) -> T! {
        let cell = dequeueReusableCell(class: aClass, for: indexPath)!
        closure?(cell)
        return cell
    }
}
