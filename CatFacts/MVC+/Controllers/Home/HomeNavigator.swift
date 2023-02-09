//
//  HomeNavigator.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import Foundation

protocol HomeNavigatorType {
    func navigate(to destination: HomeNavigator.Destination)
}

class HomeNavigator {
    enum Destination {
        case languages
    }

    private weak var controller: HomeViewController?

    init(controller: HomeViewController) {
        self.controller = controller
    }
}

// MARK: - HomeNavigatorType
extension HomeNavigator: HomeNavigatorType {
    func navigate(to destination: HomeNavigator.Destination) {
        switch destination {
            case .languages:
                break
        }
    }
}
