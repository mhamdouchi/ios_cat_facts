//
//  Endpoint.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: RequestMethod { get }
}
