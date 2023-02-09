//
//  PartialAlertAction.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import Foundation

typealias EmptyClosure = () -> Void

class PartialAlertAction {
    let title: String
    let action: EmptyClosure

    init(title: String, action: @escaping EmptyClosure) {
        self.title = title
        self.action = action
    }
}
