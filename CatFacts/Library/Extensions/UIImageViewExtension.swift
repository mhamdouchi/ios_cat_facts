//
//  UIImageViewExtension.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import UIKit

typealias UIImageCompletion = (UIImage?) -> Void

extension UIImageView {
    func load(url: URL, completion: @escaping UIImageCompletion) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                self?.image = image
                completion(image)
            }
        }
    }
}