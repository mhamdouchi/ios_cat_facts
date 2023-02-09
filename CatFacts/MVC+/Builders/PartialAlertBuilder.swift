//
//  PartialAlertBuilder.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import UIKit

enum PartialAlertBuilder {
    static func build(from _: UIViewController?, with partialAlert: PartialAlertModel) -> UIViewController? {
        guard let controller = ControllerHelper.loadViewController(PartialAlertViewController.self) as? PartialAlertViewController
        else { return nil }

        let dataSource = PartialAlertDataSource(partialAlert: partialAlert)
        let navigator = PartialAlertNavigator(controller: controller)
        let coordinator = PartialAlertCoordinator(dataSource: dataSource, navigator: navigator)

        controller.configureCoordinator(coordinator)
        controller.modalPresentationStyle = .overFullScreen

        return controller
    }
}
