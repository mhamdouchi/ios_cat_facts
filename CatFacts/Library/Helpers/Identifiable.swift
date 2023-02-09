//
//  Identifiable.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import UIKit

protocol Identifiable: UIViewController {
    static var storyboardName: String { get }
    static var controllerName: String { get }
}
