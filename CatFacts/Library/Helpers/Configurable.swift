//
//  Configurable.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import UIKit

protocol Configurable: UIViewController {
    associatedtype Model

    func configureCoordinator(_ coordinator: Model)
}
