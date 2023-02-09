//
//  PartialAlertNavigator.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import Foundation

protocol PartialAlertNavigatorType {
    func navigate(to destination: PartialAlertNavigator.Destination)
}

class PartialAlertNavigator {
    enum Destination {
        case dismiss
    }

    private weak var controller: PartialAlertViewController?

    init(controller: PartialAlertViewController) {
        self.controller = controller
    }
}

// MARK: - PartialAlertNavigatorType
extension PartialAlertNavigator: PartialAlertNavigatorType {
    func navigate(to destination: Destination) {
        switch destination {
            case .dismiss:
                controller?.dismiss(animated: false)
        }
    }
}
