//
//  HomeNavigator.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/8/23.
//

import Foundation

protocol HomeNavigatorType {
    func navigate(to destination: HomeNavigator.Destination)
}

class HomeNavigator {
    enum Destination {
        case languages
    }

    private weak var controller: HomeViewController?

    init(controller: HomeViewController) {
        self.controller = controller
    }
}

// MARK: - HomeNavigatorType
extension HomeNavigator: HomeNavigatorType {
    func navigate(to destination: HomeNavigator.Destination) {
        switch destination {
            case .languages:
                buildLanguageOptions()
        }
    }
}

extension HomeNavigator {
    private func buildLanguageOptions() {
        let partialAlert = PartialAlertModel(title: "Select a Language")

        let englishAction = PartialAlertAction(title: Language.english.title) { [weak self] in
            self?.controller?.currentLanguage = Language.english
        }
        partialAlert.addAction(englishAction)

        let germanAction = PartialAlertAction(title: Language.german.title) { [weak self] in
            self?.controller?.currentLanguage = Language.german
        }
        partialAlert.addAction(germanAction)

        let ukrainianAction = PartialAlertAction(title: Language.ukrainian.title) { [weak self] in
            self?.controller?.currentLanguage = Language.ukrainian
        }
        partialAlert.addAction(ukrainianAction)

        let russianAction = PartialAlertAction(title: Language.russian.title) { [weak self] in
            self?.controller?.currentLanguage = Language.russian
        }
        partialAlert.addAction(russianAction)

        let portugueseAction = PartialAlertAction(title: Language.portuguese.title) { [weak self] in
            self?.controller?.currentLanguage = Language.portuguese
        }
        partialAlert.addAction(portugueseAction)

        let spanishAction = PartialAlertAction(title: Language.spanish.title) { [weak self] in
            self?.controller?.currentLanguage = Language.spanish
        }
        partialAlert.addAction(spanishAction)

        let czechAction = PartialAlertAction(title: Language.czech.title) { [weak self] in
            self?.controller?.currentLanguage = Language.czech
        }
        partialAlert.addAction(czechAction)

        let filipinoAction = PartialAlertAction(title: Language.filipino.title) { [weak self] in
            self?.controller?.currentLanguage = Language.filipino
        }
        partialAlert.addAction(filipinoAction)

        let urduAction = PartialAlertAction(title: Language.urdu.title) { [weak self] in
            self?.controller?.currentLanguage = Language.urdu
        }
        partialAlert.addAction(urduAction)

        if let viewController = PartialAlertBuilder.build(from: controller, with: partialAlert) as? PartialAlertViewController {
            controller?.present(viewController, animated: false)
        }
    }
}
