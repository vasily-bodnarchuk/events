//
//  EventListViewController.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

class EventsListViewController: TableViewBasedViewController {
    
    private let eventListService: EventListService
    
    init(eventListService: EventListService) {
        self.eventListService = eventListService
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        eventListService.getAll { [weak self] result in
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
}
