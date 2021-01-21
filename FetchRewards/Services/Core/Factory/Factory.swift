//
//  Factory.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/19/21.
//

import UIKit

protocol Factory: class {
    func create(_ viewController: ViewControllerType, completion: @escaping ((UIViewController) -> Void))
}
