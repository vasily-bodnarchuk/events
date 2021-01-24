//
//  EventListViewController.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

class EventsListViewController: TableViewBasedViewController {

    private var tableViewBuilder: EventListTableViewBuilder!
    private var keyboardNotifications: KeyboardNotifications!
    private var activityIndicator: LoadMoreActivityIndicator?

    func set(eventListTableViewBuilder: EventListTableViewBuilder) {
        self.tableViewBuilder = eventListTableViewBuilder
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

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
        setNeedsStatusBarAppearanceUpdate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardNotifications.isEnabled = false
    }

    private func setup(navigationBar: UINavigationBar) {
      //  navigationBar. = .black
        navigationBar.barTintColor = UIColor(r: 38, g: 54, b: 68)
        navigationBar.tintColor = UIColor.white
        navigationBar.isTranslucent = false
    }

    @objc override func pullToRefreshHandler(_ refreshControl: UIRefreshControl) {
        tableViewBuilder.reloadViewModels { [weak self] response in
            self?.setViewModels(from: response) { self?.tableView.endRefreshing() }
        }
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

    private func setViewModels(from response: Result<[TableViewCellViewModelInterface], Error>, completion: (() -> Void)? = nil) {
        defer { completion?() }
        switch response {
        case .failure(let error): self.showAlert(error: error)
        case .success(let viewModels):
            tableView.registerOnlyUnknownCells(with: viewModels)
            self.viewModels = viewModels
            tableView.reloadData { [weak self] tableView in
                guard let self = self else { return }
                if self.activityIndicator == nil {
                    self.activityIndicator = LoadMoreActivityIndicator(scrollView: tableView,
                                                                       spacingFromLastCell: 10,
                                                                       spacingFromLastCellWhenLoadMoreActionStart: 60)
                }
            }
        }
    }

    func makeSearchRequest(keyword: String? = nil, completion: (() -> Void)? = nil) {
        tableViewBuilder.getViewModelsForTheFirstPage(searchEventsBy: keyword) { [weak self] result in
            guard let self = self else { return }
            var _result: Result<[TableViewCellViewModelInterface], Error>!
            switch result {
            case let .viewModels(array, tableViewProperties):
                _result = .success(array)
                self.setTableView(properties: tableViewProperties)
            }
            self.setViewModels(from: _result, completion: completion)
        }
    }
}

extension EventsListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        activityIndicator?.start { [weak self] in
            guard let self = self else { return }
            self.tableViewBuilder.getViewModelsForTheNextPage { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    self.showAlert(error: error)
                    self.activityIndicator?.stop()
                case .success(let value):
                    switch value {
                    case .alreadyLoadedLastPage:
                        self.activityIndicator = nil
                    case .viewModels(let array):
                        self.tableView.registerOnlyUnknownCells(with: array)
                        self.viewModels += array
                        self.activityIndicator?.stop()
                        let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                        let indexPaths = (numberOfRows...numberOfRows+array.count-1).map { IndexPath(row: $0, section: 0) }
                        self.tableView.insertRows(at: indexPaths, with: .automatic)
                    }
                }
            }
        }
    }
}

extension EventsListViewController: EventTableViewCellViewModelDelegate {
    func didSelect(cell: EventTableViewCell, viewModel: EventTableViewCellViewModel) {
        router.route(to: .push(when: .always(type: .events(.alreadyLoaded(event: viewModel.event)),
                                             animated: true)))
    }
}
