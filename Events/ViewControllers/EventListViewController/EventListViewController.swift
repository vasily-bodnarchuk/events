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
    override var viewModels: [TableViewCellViewModelInterface] { tableViewBuilder.viewModels }

    func set(eventListTableViewBuilder: EventListTableViewBuilder) {
        self.tableViewBuilder = eventListTableViewBuilder
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewBuilder.tableView = tableView
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

    @objc override func pullToRefreshHandler(_ refreshControl: UIRefreshControl) {
        tableViewBuilder.reloadViewModels { [weak self] response in
            switch response {
            case .failure(let error): self?.showAlert(error: error)
            case .success: self?.reloadTableView { self?.tableView.endRefreshing() }
            }
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

    private func reloadTableView(completion: (() -> Void)? = nil) {
        tableView.reloadData { [weak self] tableView in
            guard let self = self else { return }
            if self.activityIndicator == nil {
                self.activityIndicator = LoadMoreActivityIndicator(scrollView: tableView,
                                                                   spacingFromLastCell: 10,
                                                                   spacingFromLastCellWhenLoadMoreActionStart: 60)
            }
            completion?()
        }
    }

    func makeSearchRequest(keyword: String? = nil, completion: (() -> Void)? = nil) {
        tableViewBuilder.loadViewModelsForTheFirstPage(searchEventsBy: keyword) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .reloadTableView(let properties): self.setTableView(properties: properties)
            }
            self.reloadTableView()
        }
    }
}

extension EventsListViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        activityIndicator?.start { [weak self] in
            guard let self = self else { return }
            self.tableViewBuilder.loadViewModelsForTheNextPage { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    self.showAlert(error: error)
                    self.activityIndicator?.stop()
                case .success(let value):
                    switch value {
                    case .alreadyLoadedLastPage:
                        self.activityIndicator = nil
                    case .addedMoreViewModels(let count):
                        self.activityIndicator?.stop()
                        let numberOfRows = self.tableView.numberOfRows(inSection: 0)
                        let indexPaths = (numberOfRows...numberOfRows+count-1).map { IndexPath(row: $0, section: 0) }
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
