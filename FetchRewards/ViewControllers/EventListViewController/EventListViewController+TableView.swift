//
//  EventListViewController+TableView.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import UIKit

// extension EventsListViewController {
//    func createTableView(embedIn parentView: UIView) -> ViewModelCellBasedTableView {
//        let tableView = ViewModelCellBasedTableView ()
//        tableView.tableFooterView = UIView()
//        tableView.dataSource = self
//        tableView.delegate = self
//        parentView.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        return tableView
//    }
// }
//
// extension EventsListViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int { viewModels.isEmpty ? 0 : 1 }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModels.count }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        viewModels[indexPath.row].getCell(from: tableView.self as! ViewModelCellBasedTableView, at: indexPath, delegate: nil) ?? UITableViewCell()
//    }
// }
//
// extension EventsListViewController: UITableViewDelegate {}
