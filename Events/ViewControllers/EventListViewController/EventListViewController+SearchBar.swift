//
//  EventListViewController+SearchBar..swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/20/21.
//

import UIKit

 extension EventsListViewController {
    func createSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search event"
        searchBar.set(textColor: .white)
        return searchBar
    }
 }

extension EventsListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        makeSearchRequest(keyword: searchText)
    }
}
