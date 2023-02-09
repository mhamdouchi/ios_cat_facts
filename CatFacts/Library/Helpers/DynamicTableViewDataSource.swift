//
//  DynamicTableViewDataSource.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import UIKit

public class DynamicTableViewDataSource: NSObject {
    private weak var controller: UIViewController?
    private(set) var cellProxies: [DynamicTableViewCellProxy] = []

    public var count: Int {
        cellProxies.count
    }

    public init(controller: UIViewController, cellProxies: [DynamicTableViewCellProxy]) {
        self.controller = controller
        self.cellProxies = cellProxies
    }

    public func updateCellProxies(_ cellProxies: [DynamicTableViewCellProxy]) {
        self.cellProxies = cellProxies
    }
}

// MARK: - UITableViewDataSource
extension DynamicTableViewDataSource: UITableViewDataSource {
    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        cellProxies.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellProxy = cellProxies[safe: indexPath.row]
        else { return UITableViewCell() }

        return cellProxy.configureCell(controller, tableView: tableView, indexPath: indexPath)
    }
}
