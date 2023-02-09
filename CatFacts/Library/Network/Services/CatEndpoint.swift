//
//  CatEndpoint.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import Foundation

enum CatEndpoint {
    case fetchCatFunFact(_ language: String?)
}

extension CatEndpoint: Endpoint {
    var path: String {
        switch self {
            case let .fetchCatFunFact(language):
                return "https://meowfacts.herokuapp.com/?lang=\(language ?? "eng")"
        }
    }

    var method: RequestMethod {
        switch self {
            case .fetchCatFunFact:
                return .get
        }
    }
}
