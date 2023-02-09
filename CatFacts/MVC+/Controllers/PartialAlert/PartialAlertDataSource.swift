//
//  PartialAlertDataSource.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import Foundation

protocol PartialAlertDataSourceType {
    var partialAlert: PartialAlertModel { get }

    func fetchAlertOptionsCells() -> [DynamicTableViewCellProxy]
}

class PartialAlertDataSource {
    private let partialAlertObject: PartialAlertModel

    init(partialAlert: PartialAlertModel) {
        partialAlertObject = partialAlert
    }
}

// MARK: - PartialAlertDataSourceType
extension PartialAlertDataSource: PartialAlertDataSourceType {
    var partialAlert: PartialAlertModel {
        return partialAlertObject
    }

    func fetchAlertOptionsCells() -> [DynamicTableViewCellProxy] {
        var cellProxies: [DynamicTableViewCellProxy] = []

        for alertOption in partialAlertObject.actions {
            cellProxies.append(AlertOptionCellProxy(alertOption: alertOption))
        }

        return cellProxies
    }
}
