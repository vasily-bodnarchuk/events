//
//  EventHeaderTableViewCellViewModel.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

// MARK: ViewModel Delegate

protocol EventHeaderTableViewCellViewModelDelegate: ViewModelDelegate {
    func backIconTapped(in cell: EventHeaderTableViewCell, viewModel: EventHeaderTableViewCellViewModel)
    func favoriteIconTapped(in cell: EventHeaderTableViewCell, viewModel: EventHeaderTableViewCellViewModel)
}

// MARK: ViewModel

class EventHeaderTableViewCellViewModel: TableViewCellViewModel<EventHeaderTableViewCell> {

    private weak var delegate: EventHeaderTableViewCellViewModelDelegate!
    private let title: String
    let isFavorited: Bool

    init(title: String, isFavorited: Bool, delegate: EventHeaderTableViewCellViewModelDelegate) {
        self.title = title
        self.isFavorited = isFavorited
        self.delegate = delegate
    }

    override func getCell(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath) -> UITableViewCell? {
        tableView.dequeueReusableCell(forceUnwrap: TableViewCell.self,
                                      for: indexPath) { [weak self] cell in
            guard let self = self else { return }
            cell.set(title: self.title, isFavorited: self.isFavorited, delegate: self)
        }
    }
}

extension EventHeaderTableViewCellViewModel: EventHeaderTableViewCellDelegate {
    func backIconTapped(in cell: EventHeaderTableViewCell) {
        delegate.backIconTapped(in: cell, viewModel: self)
    }

    func favoriteIconTapped(in cell: EventHeaderTableViewCell) {
        delegate.favoriteIconTapped(in: cell, viewModel: self)
    }
}

// MARK: View Delegate

protocol EventHeaderTableViewCellDelegate: class {
    func backIconTapped(in cell: EventHeaderTableViewCell)
    func favoriteIconTapped(in cell: EventHeaderTableViewCell)
}

// MARK: View

class EventHeaderTableViewCell: TableViewCell {
    private weak var titleLabel: UILabel!
    private weak var favoriteImageView: UIImageView!
    private weak var delegate: EventHeaderTableViewCellDelegate!

    override func setup() {
        super.setup()
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 16
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentView.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 16).isActive = true

        stackView.addArrangedSubview(createInteractiveImageView(image: Asset.navigationBackIcon.image,
                                                                action: #selector(backIconTapped)))
        titleLabel = addArrangedLabel(to: stackView,
                                      font: .systemFont(ofSize: 24, weight: .semibold),
                                      textColor: .black,
                                      textAlignment: .center)

        let imageView = createInteractiveImageView(image: nil, action: #selector(favoriteIconTapped))
        stackView.addArrangedSubview(imageView)
        favoriteImageView = imageView
    }

    private func createInteractiveImageView(image: UIImage?, sideDimension: CGFloat = 34,
                                            action: Selector) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: sideDimension).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: sideDimension).isActive = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
        return imageView
    }

    func set(title: String, isFavorited: Bool, delegate: EventHeaderTableViewCellDelegate) {
        titleLabel.text = title
        set(isFavorited: isFavorited)
        self.delegate = delegate
    }

    func set(isFavorited: Bool) {
        favoriteImageView.image = isFavorited ? Asset.favoriteIcon.image : Asset.notFavoriteIcon.image
    }
}

// MARK: Actions

extension EventHeaderTableViewCell {
    @objc func backIconTapped() { delegate.backIconTapped(in: self) }
    @objc func favoriteIconTapped() { delegate.favoriteIconTapped(in: self) }
}

// MARK: ArrangedLabelAddable

extension EventHeaderTableViewCell: ArrangedLabelAddable { }
