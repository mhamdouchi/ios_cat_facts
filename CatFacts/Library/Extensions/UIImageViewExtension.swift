//
//  UIImageViewExtension.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import UIKit

extension UIImageView {
    func load(url: URL, completion: @escaping CompletionHandler<UIImage?>) {
        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
