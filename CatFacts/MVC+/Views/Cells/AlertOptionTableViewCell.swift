//
//  AlertOptionTableViewCell.swift
//  CatFacts
//
//  Created by Mohamed Hamdouchi on 2/9/23.
//

import UIKit

protocol AlertOptionCellActionable: AnyObject {
    func didSelect(_ alertOption: PartialAlertAction)
}

class AlertOptionCellProxy {
    private let alertOption: PartialAlertAction

    init(alertOption: PartialAlertAction) {
        self.alertOption = alertOption
    }
}

extension AlertOptionCellProxy: DynamicTableViewCellProxy {
    func configureCell<T>(_ controller: T, tableView: UITableView, indexPath _: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertOptionCellIdentifier") as? AlertOptionTableViewCell else { return UITableViewCell() }

        cell.delegate = controller as? AlertOptionCellActionable
        cell.alertOption = alertOption

        return cell
    }
}

class AlertOptionTableViewCell: UITableViewCell {
    private enum Design {
        static let pointSize: CGFloat = 16.0
        static let radiusView: CGFloat = 10.0
    }

    fileprivate var alertOption: PartialAlertAction? {
        didSet {
            if let alertOption = alertOption {
                loadContent(alertOption)
            }
        }
    }

    fileprivate weak var delegate: AlertOptionCellActionable?

    @IBOutlet private var viewContainer: UIView!
    @IBOutlet private var labelAlertOption: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        viewContainer.toShape(.rounded(Design.radiusView))

        configureGestures()
    }
}

// MARK: - Gestures
extension AlertOptionTableViewCell {
    private func configureGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOption))
        viewContainer.addGestureRecognizer(tap)
    }

    @objc private func didTapOption() {
        if let alertOption = alertOption {
            delegate?.didSelect(alertOption)
        }
    }
}

// MARK: - Content
extension AlertOptionTableViewCell {
    private func loadContent(_ alertOption: PartialAlertAction) {
        labelAlertOption.text = alertOption.title
    }
}
