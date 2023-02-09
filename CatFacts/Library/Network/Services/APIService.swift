//
//  APIService.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import Foundation

typealias CompletionHandler<T> = (_ input: T) -> Void

struct APIService: HTTPClient {
    static let shared = APIService(session: URLSession.shared)

    private(set) var session: CustomSession

    init(session: CustomSession) {
        self.session = session
    }
}
