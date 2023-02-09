//
//  HomeDataSource.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import UIKit

protocol HomeDataSourceType {
    func load(url: String, completion: @escaping CompletionHandler<UIImageView?>)
    func fetchFact(_ language: Language?, _ completion: @escaping CompletionHandler<String?>)
}

class HomeDataSource {
    private let apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }
}

// MARK: - HomeDataSourceType
extension HomeDataSource: HomeDataSourceType {
    func load(url: String, completion: @escaping CompletionHandler<UIImageView?>) {
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

    func fetchFact(_ language: Language?, _ completion: @escaping CompletionHandler<String?>) {
        Task(priority: .background) {
            let result = await apiService.fetchCatFact(language)

            switch result {
                case let .success(catFact):
                    DispatchQueue.main.async {
                        completion(catFact.data.first)
                    }

                case .failure:
                    DispatchQueue.main.async {
                        completion(nil)
                    }
            }
        }
    }
}
