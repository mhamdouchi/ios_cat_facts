//
//  DynamicTableViewCellProxy.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import UIKit

public protocol DynamicTableViewCellProxy {
    func configureCell<T>(_ controller: T, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}
