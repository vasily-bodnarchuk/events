//
//  TableViewBasedViewController.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import UIKit

class TableViewBasedViewController: UIViewController {
    var viewModels = [TableViewCellViewModelInterface]()
    private(set) weak var tableView: ViewModelCellBasedTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView = createTableView(embedIn: view)
    }
}

extension TableViewBasedViewController {
    func createTableView(embedIn parentView: UIView) -> ViewModelCellBasedTableView {
        let tableView = ViewModelCellBasedTableView()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        parentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        return tableView
    }
}

// MARK: UITableViewDataSource

extension TableViewBasedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { viewModels.isEmpty ? 0 : 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModels.count }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModels[indexPath.row].getCell(for: tableView.self as! ViewModelCellBasedTableView, at: indexPath, delegate: nil) ?? UITableViewCell()
    }
}

// MARK: UITableViewDelegate

extension TableViewBasedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModels[indexPath.row].getRowHight(for: tableView.self as! ViewModelCellBasedTableView, at: indexPath)
    }
}
