//
//  PartialAlertViewController.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import UIKit

class PartialAlertViewController: UIViewController {
    private var coordinator: PartialAlertCoordinator?
    private var tableViewDataSource: DynamicTableViewDataSource?

    private enum Constants {
        static let duration: CGFloat = 0.2
        static let alpha50: CGFloat = 0.5
        static let alpha100: CGFloat = 1.0
        static let radius: CGFloat = 40.0
    }

    @IBOutlet private var viewDragBar: UIView!
    @IBOutlet private var viewDrawer: UIView!
    @IBOutlet private var labelTitle: UILabel!
    @IBOutlet private var tableView: UITableView!
}

// MARK: - Identifiable
extension PartialAlertViewController: Identifiable {
    static var storyboardName: String {
        "PartialAlert"
    }

    static var controllerName: String {
        "PartialAlertVC"
    }
}

// MARK: - Configurable
extension PartialAlertViewController: Configurable {
    func configureCoordinator(_ coordinator: PartialAlertCoordinator) {
        self.coordinator = coordinator
    }
}

// MARK: - Lifecycle
extension PartialAlertViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureUI()
        configureGestures()

        loadTitle()
        loadContent()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewDrawer.frame = CGRect(x: .zero, y: view.frame.height, width: viewDrawer.frame.width, height: viewDrawer.frame.height)
        openDrawer()
    }
}

// MARK: - Configure Tableview
extension PartialAlertViewController {
    private func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60.0
        tableView.tableFooterView = UIView()

        tableView.register(UINib(nibName: "AlertOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "AlertOptionCellIdentifier")
    }
}

// MARK: - Interface
extension PartialAlertViewController {
    private func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(.zero)
        viewDragBar.toShape(.circle)
        viewDrawer.toShape(.rounded(Constants.radius))
        viewDrawer.alpha = .zero
    }
}

// MARK: - Gestures
extension PartialAlertViewController {
    private func configureGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeDrawer))
        view.addGestureRecognizer(tapGesture)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        viewDrawer.addGestureRecognizer(panGesture)
    }

    @objc private func draggedView(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: viewDrawer)
        let y = viewDrawer.frame.minY

        let newPosition = y + translation.y
        if newPosition >= view.frame.height - viewDrawer.frame.height {
            viewDrawer.frame = CGRect(x: .zero, y: newPosition, width: viewDrawer.frame.width, height: viewDrawer.frame.height)
            recognizer.setTranslation(.zero, in: viewDrawer)
        }

        let velocity = recognizer.velocity(in: viewDrawer)
        if recognizer.state == .ended {
            if velocity.y >= .zero {
                closeDrawer()
            } else {
                openDrawer()
            }
        }
    }
}

// MARK: - Content
extension PartialAlertViewController {
    private func loadTitle() {
        if let alertTitle = coordinator?.partialAlert.title {
            labelTitle.text = alertTitle
        }
    }

    private func loadContent() {
        if let cellProxies = coordinator?.fetchAlertOptionsCells() {
            tableViewDataSource = DynamicTableViewDataSource(controller: self, cellProxies: cellProxies)
            tableView.dataSource = tableViewDataSource
            tableView.reloadData()
        }
    }
}

// MARK: - Helper Methods
extension PartialAlertViewController {
    private func openDrawer() {
        UIView.animate(withDuration: Constants.duration) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(Constants.alpha50)
            self.viewDrawer.alpha = Constants.alpha100
            self.viewDrawer.frame = CGRect(x: .zero, y: self.view.frame.height - self.viewDrawer.frame.height, width: self.viewDrawer.frame.width, height: self.viewDrawer.frame.height)
        }
    }

    @objc private func closeDrawer() {
        UIView.animate(withDuration: Constants.duration, delay: .zero, options: [.allowUserInteraction]) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(.zero)
            self.viewDrawer.alpha = .zero
            self.viewDrawer.frame = CGRect(x: .zero, y: self.view.frame.height, width: self.viewDrawer.frame.width, height: self.viewDrawer.frame.height)
        } completion: { completed in
            if completed {
                self.coordinator?.navigate(to: .dismiss)
            }
        }
    }
}

// MARK: - InvestOptionCellActionable
extension PartialAlertViewController: AlertOptionCellActionable {
    func didSelect(_ alertOption: PartialAlertAction) {
        alertOption.action()
        closeDrawer()
    }
}
