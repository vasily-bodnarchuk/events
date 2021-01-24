//
//  EventViewController.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

class EventViewController: TableViewBasedViewController {

    private var tableViewBuilder: EventTableViewBuilder!

    override var preferredStatusBarStyle: UIStatusBarStyle { .default }

    func set(eventTableViewBuilder: EventTableViewBuilder) {
        self.tableViewBuilder = eventTableViewBuilder
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewBuilder.getViewModels { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error): self.showAlert(error: error)
            case .success(let viewModels):
                self.tableView.registerOnlyUnknownCells(with: viewModels)
                self.viewModels = viewModels
                self.tableView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: EventHeaderTableViewCellViewModelDelegate

extension EventViewController: EventHeaderTableViewCellViewModelDelegate {
    func backIconTapped(in cell: EventHeaderTableViewCell, viewModel: EventHeaderTableViewCellViewModel) {
        router.route(to: .back(when: .always(route: .popViewController(animated: true))))
    }

    func favoriteIconTapped(in cell: EventHeaderTableViewCell, viewModel: EventHeaderTableViewCellViewModel) {
        print("!!!!! favoriteIconTapped")
    }
}
