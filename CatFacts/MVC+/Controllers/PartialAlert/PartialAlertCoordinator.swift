//
//  PartialAlertCoordinator.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import Foundation

protocol PartialAlertCoordinatorDataSourceType {
    var partialAlert: PartialAlertModel { get }

    func fetchAlertOptionsCells() -> [DynamicTableViewCellProxy]
}

protocol PartialAlertCoordinatorNavigatorType {
    func navigate(to destination: PartialAlertNavigator.Destination)
}

class PartialAlertCoordinator {
    private let dataSource: PartialAlertDataSource
    private let navigator: PartialAlertNavigator

    init(dataSource: PartialAlertDataSource, navigator: PartialAlertNavigator) {
        self.dataSource = dataSource
        self.navigator = navigator
    }
}

// MARK: - PartialAlertCoordinatorDataSourceType
extension PartialAlertCoordinator: PartialAlertCoordinatorDataSourceType {
    var partialAlert: PartialAlertModel {
        dataSource.partialAlert
    }

    func fetchAlertOptionsCells() -> [DynamicTableViewCellProxy] {
        dataSource.fetchAlertOptionsCells()
    }
}

// MARK: - PartialAlertCoordinatorNavigator
extension PartialAlertCoordinator: PartialAlertCoordinatorNavigatorType {
    func navigate(to destination: PartialAlertNavigator.Destination) {
        navigator.navigate(to: destination)
    }
}
