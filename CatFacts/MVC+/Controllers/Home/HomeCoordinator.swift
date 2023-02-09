//
//  HomeCoordinator.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import Foundation

protocol HomeCoordinatorDataSourceType {
    func load(url: String, completion: @escaping UIImageViewCompletion)
}

class HomeCoordinator {
    private let dataSource: HomeDataSource
    private let navigator: HomeNavigator

    init(dataSource: HomeDataSource, navigator: HomeNavigator) {
        self.dataSource = dataSource
        self.navigator = navigator
    }
}

// MARK: - HomeCoordinatorDataSourceType
extension HomeCoordinator: HomeCoordinatorDataSourceType {
    func load(url: String, completion: @escaping UIImageViewCompletion) {
        dataSource.load(url: url) { imageView in
            completion(imageView)
        }
    }
}
