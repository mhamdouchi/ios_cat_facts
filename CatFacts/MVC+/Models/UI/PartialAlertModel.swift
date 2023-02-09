//
//  PartialAlertModel.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import Foundation

class PartialAlertModel {
    let title: String
    private(set) var actions: [PartialAlertAction] = []

    init(title: String) {
        self.title = title
    }

    func addAction(_ action: PartialAlertAction) {
        actions.append(action)
    }
}
