//
//  Language.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import Foundation

enum Language {
    case english
    case german
    case ukrainian
    case russian
    case portuguese
    case spanish
    case czech
    case filipino
    case urdu

    var symbol: String {
        switch self {
            case .english: return "eng"
            case .german: return "ger"
            case .ukrainian: return "ukr"
            case .russian: return "rus"
            case .portuguese: return "por"
            case .spanish: return "esp"
            case .czech: return "ces"
            case .filipino: return "tl"
            case .urdu: return "ud"
        }
    }

    var title: String {
        switch self {
            case .english: return "English"
            case .german: return "German"
            case .ukrainian: return "Ukrainian"
            case .russian: return "Russian"
            case .portuguese: return "Portuguese"
            case .spanish: return "Spanish"
            case .czech: return "Czech"
            case .filipino: return "Filipino"
            case .urdu: return "Urdu"
        }
    }
}
