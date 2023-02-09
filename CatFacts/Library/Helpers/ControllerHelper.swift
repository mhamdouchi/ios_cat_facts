//
//  ControllerHelper.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import UIKit

enum ControllerHelper {
    typealias ConfigurableController = Configurable & Identifiable

    static func loadViewController<T: ConfigurableController>(_: T.Type) -> UIViewController? {
        let storyboard = UIStoryboard(name: T.storyboardName, bundle: nil)

        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.controllerName) as? T
        else { return nil }

        return viewController
    }
}
