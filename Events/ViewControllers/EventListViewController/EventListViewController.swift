//
//  EventListViewController.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

class EventsListViewController: TableViewBasedViewController {

    private let eventListService: EventListService
    private var keyboardNotifications: KeyboardNotifications!

    init(eventListService: EventListService) {
        self.eventListService = eventListService
        super.init(nibName: nil, bundle: nil)
        self.keyboardNotifications = KeyboardNotifications(notifications: [.willShow, .willHide], delegate: self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationBar = navigationController?.navigationBar { setup(navigationBar: navigationBar) }
        navigationItem.titleView = createSearchBar()
        tableView.keyboardDismissMode = .interactive
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardNotifications.isEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardNotifications.isEnabled = false
    }

    private func setup(navigationBar: UINavigationBar) {
        navigationBar.barTintColor = UIColor(r: 38, g: 54, b: 68)
        navigationBar.tintColor = UIColor.white
        navigationBar.isTranslucent = false
    }
}

extension EventsListViewController: KeyboardNotificationsDelegate {

    func keyboardWillShow(notification: NSNotification) {
        guard   let userInfo = notification.userInfo as? [String: NSObject],
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        tableView.contentInset.bottom = keyboardFrame.height
    }

    func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset.bottom = 0
    }
}
