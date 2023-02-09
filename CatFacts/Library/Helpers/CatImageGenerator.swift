//
//  CatImageGenerator.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import Foundation

struct CatImageGenerator {
    static func generate() -> String {
        let width = Int.random(in: 200 ... 300)
        let height = Int.random(in: 200 ... 300)
        let urlString = "https://placekitten.com/g/\(width)/\(height)"

        return urlString
    }
}
