//
//  HomeCoordinator.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import UIKit

protocol HomeCoordinatorDataSourceType {
    func load(url: String, completion: @escaping CompletionHandler<UIImageView?>)
    func fetchFact(_ language: Language?, _ completion: @escaping CompletionHandler<String?>)
}

protocol HomeCoordinatorNavigatorType {
    func navigate(to destination: HomeNavigator.Destination)
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
    func load(url: String, completion: @escaping CompletionHandler<UIImageView?>) {
        dataSource.load(url: url) { imageView in
            completion(imageView)
        }
    }

    func fetchFact(_ language: Language?, _ completion: @escaping CompletionHandler<String?>) {
        dataSource.fetchFact(language) { fact in
            completion(fact)
        }
    }
}

// MARK: - HomeCoordinatorNavigatorType
extension HomeCoordinator: HomeCoordinatorNavigatorType {
    func navigate(to destination: HomeNavigator.Destination) {
        navigator.navigate(to: destination)
    }
}
