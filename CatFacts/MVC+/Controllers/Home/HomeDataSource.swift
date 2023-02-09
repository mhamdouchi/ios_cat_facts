//
//  HomeDataSource.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import UIKit

typealias UIImageViewCompletion = (UIImageView?) -> Void

protocol HomeDataSourceType {
    func load(url: String, completion: @escaping UIImageViewCompletion)
}

class HomeDataSource {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }
}

// MARK: - HomeDataSourceType
extension HomeDataSource: HomeDataSourceType {
    func load(url: String, completion: @escaping UIImageViewCompletion) {
        guard let imageURL = URL(string: url)
        else {
            completion(nil)
            return
        }

        let imageView = UIImageView()

        imageView.load(url: imageURL) { image in
            if let image = image {
                imageView.image = image
                completion(imageView)
            } else {
                completion(nil)
            }
        }
    }
}
