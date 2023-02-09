//
//  FactEndpoint.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import Foundation

enum FactEndpoint {
    case fetchCatFact(_ language: String?)
}

extension FactEndpoint: Endpoint {
    var path: String {
        switch self {
            case let .fetchCatFact(language):
                return "https://meowfacts.herokuapp.com/?lang=\(language ?? "eng")"
        }
    }

    var method: RequestMethod {
        switch self {
            case .fetchCatFact:
                return .get
        }
    }
}
