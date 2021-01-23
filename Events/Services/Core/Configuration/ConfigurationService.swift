//
//  ConfigurationService.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import Foundation

protocol ConfigurationService: class {
    var apiHost: String { get }
    var clientId: String { get }
}
