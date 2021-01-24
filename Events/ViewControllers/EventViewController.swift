//
//  EventViewController.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

class EventViewController: TableViewBasedViewController {

    private let tableViewBuilder: EventTableViewBuilder

    init(eventTableViewBuilder: EventTableViewBuilder) {
        self.tableViewBuilder = eventTableViewBuilder
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewBuilder.getViewModels { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error): break
            case .success(let viewModels):
                self.tableView.registerOnlyUnknownCells(with: viewModels)
                self.viewModels = viewModels
                self.tableView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
