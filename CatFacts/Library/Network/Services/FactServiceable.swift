//
//  FactServiceable.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import Foundation

protocol FactServiceable {
    func fetchCatFact(_ language: Language?) async -> Result<CatFact, RequestError>
}
