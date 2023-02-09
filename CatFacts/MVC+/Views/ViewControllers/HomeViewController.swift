//
//  HomeViewController.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import UIKit

class HomeViewController: UIViewController {
    private enum LoadingState {
        case loading
        case completed
    }

    private var coordinator: HomeCoordinator?

    @IBOutlet var imageViewCat: UIImageView!
    @IBOutlet var labelCatFact: UILabel!

    private var loadingState: LoadingState = .loading
}

// MARK: - Lifecycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCoordinator()
        configureUI()
        configureGestures()

        loadCatImage()
    }
}

// MARK: - Coordinator
extension HomeViewController {
    private func configureCoordinator() {
        let dataSource = HomeDataSource(apiService: APIService.shared)
        let navigator = HomeNavigator(controller: self)
        let coordinator = HomeCoordinator(dataSource: dataSource, navigator: navigator)

        self.coordinator = coordinator
    }
}

// MARK: - Interface
extension HomeViewController {
    private func configureUI() {
        imageViewCat.layer.cornerRadius = 10
    }
}

// MARK: - Content
extension HomeViewController {
    private func loadCatImage() {
        let url = CatImageGenerator.generate()

        coordinator?.load(url: url, completion: { [weak self] imageView in
            if let imageView = imageView {
                self?.imageViewCat.image = imageView.image
            }

            self?.loadingState = .completed
        })
    }
}

// MARK: - Gestures
extension HomeViewController {
    private func configureGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapScreen(_:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1

        view.addGestureRecognizer(tap)
    }

    @objc private func didTapScreen(_: UITapGestureRecognizer) {
        switch loadingState {
            case .completed:
                loadingState = .loading
                loadCatImage()

            case .loading:
                debugPrint("Please wait while loading a new cute cat image")
        }
    }
}
