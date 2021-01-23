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
    private var activityIndicator: LoadMoreActivityIndicator?

    init(eventListService: EventListService) {
        self.eventListService = eventListService
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let navigationBar = navigationController?.navigationBar { setup(navigationBar: navigationBar) }
        navigationItem.titleView = createSearchBar()
        tableView.keyboardDismissMode = .interactive
        keyboardNotifications = KeyboardNotifications(notifications: [.willShow, .willHide], delegate: self)
        makeSearchRequest()
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

// MARK: KeyboardNotificationsDelegate

extension EventsListViewController: KeyboardNotificationsDelegate {

    func keyboardWillShow(notification: NSNotification) {
        guard   let userInfo = notification.userInfo as? [String: NSObject],
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        tableView.contentInset.bottom = keyboardFrame.height
        activityIndicator?.defaultBottomContentInset = keyboardFrame.height
    }

    func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset.bottom = 0
        activityIndicator?.defaultBottomContentInset = 0
    }
}

// MARK: Work with data

extension EventsListViewController {

    func makeSearchRequest(keyword: String? = nil) {
        eventListService.loadAll(searchBy: keyword) { [weak self] result in
            switch result {
            case .failure(let error): break
            case .success(let viewModels):
                guard let self = self else { return }
                if self.activityIndicator == nil {
                    self.activityIndicator = LoadMoreActivityIndicator(scrollView: self.tableView,
                                                                       spacingFromLastCell: 10,
                                                                       spacingFromLastCellWhenLoadMoreActionStart: 60)
                }
                print("!!!! \(viewModels)")
                if viewModels.count == 1 && self.viewModels.count == 1 { return }
                self.tableView.registerOnlyUnknownCells(with: viewModels)
                self.viewModels = viewModels
                self.tableView.reloadData()
            }
        }
    }
}

extension EventsListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        activityIndicator?.start { [weak self] in
            self?.eventListService.loadNextPageIfPossible { result in
                guard let self = self else { return }
                defer { self.activityIndicator?.stop() }
                switch result {
                case .failure(let error): break
                case .success(let value):
                    switch value {
                    case .alreadyLoadedLastPage:
                        self.activityIndicator = nil
                    case .viewModels(let array):
                        self.tableView.registerOnlyUnknownCells(with: array)
                        self.viewModels += array
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
