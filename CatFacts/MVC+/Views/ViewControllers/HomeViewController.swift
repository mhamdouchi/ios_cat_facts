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
    private var loadingState: LoadingState = .loading

    var currentLanguage: Language? {
        didSet {
            loadCatImage(currentLanguage)
        }
    }

    @IBOutlet var imageViewCat: UIImageView!
    @IBOutlet var labelCatFact: UILabel!

    @IBAction func didTapLanguages(_: UIBarButtonItem) {
        coordinator?.navigate(to: .languages)
    }
}

// MARK: - Lifecycle
extension HomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCoordinator()
        configureUI()
        configureContent()
        configureGestures()

        currentLanguage = .english
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
    private func configureContent() {
        title = "Cat Facts"
    }

    private func loadCatImage(_ language: Language?) {
        clearCatImage()
        clearCatFact()

        let url = CatImageGenerator.generate()

        coordinator?.load(url: url, completion: { [weak self] imageView in
            if let imageView = imageView {
                self?.imageViewCat.image = imageView.image
                self?.loadCatFact(language)
            }

            self?.loadingState = .completed
        })
    }

    private func loadCatFact(_ language: Language?) {
        coordinator?.fetchFact(language) { [weak self] fact in
            self?.labelCatFact.text = fact
        }
    }

    private func clearCatImage() {
        imageViewCat.image = nil
    }

    private func clearCatFact() {
        labelCatFact.text = nil
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
                loadCatImage(currentLanguage)

            case .loading:
                debugPrint("Please wait while loading a new cute cat image")
        }
    }
}
