//
//  ViewModelCellBasedTableView.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import UIKit

import Foundation

class ViewModelCellBasedTableView: UITableView {
    private lazy var registeredCellIdentifiers = Set<String>()
}

// MARK: Register table view cells

protocol TableViewCellViewModelRegistarable: class {
    func registerOnlyUnknownCells(with viewModels: [TableViewCellViewModelInterface])
}

extension ViewModelCellBasedTableView: TableViewCellViewModelRegistarable {
    func registerOnlyUnknownCells(with viewModels: [TableViewCellViewModelInterface]) {
        for viewModel in viewModels {
            let classToRegister = viewModel.getCellClassForRegister(in: self)
            if registeredCellIdentifiers.contains(classToRegister.identifier) { continue }
            super.register(classToRegister.self, forCellReuseIdentifier: classToRegister.identifier)
            registeredCellIdentifiers.insert(classToRegister.identifier)
        }
    }
    
    @available(*, deprecated, message: "use registerOnlyUnknownCells(with viewModels: [TableViewCellViewModel]) instead")
    override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {}
    
    @available(*, deprecated, message: "use registerOnlyUnknownCells(with viewModels: [TableViewCellViewModel]) instead")
    override func register(_ nib: UINib?, forHeaderFooterViewReuseIdentifier identifier: String) { }
    
    @available(*, deprecated, message: "use registerOnlyUnknownCells(with viewModels: [TableViewCellViewModel]) instead")
    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {}
    
    @available(*, deprecated, message: "use registerOnlyUnknownCells(with viewModels: [TableViewCellViewModel]) instead")
    override func register(_ aClass: AnyClass?, forHeaderFooterViewReuseIdentifier identifier: String) {}
}
