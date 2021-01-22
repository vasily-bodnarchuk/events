//
//  EventTableViewCellViewModel.swift
//  FetchRewards
//
//  Created by Vasily Bodnarchuk on 1/22/21.
//

import UIKit
import Nuke
// MARK: ViewModel

class EventTableViewCellViewModel: TableViewCellViewModel<EventTableViewCell> {

    let id: Int
    let title: String
    let location: String
    let date: String
    let imageUrl: URL

    init(id: Int, title: String, location: String, date: String, imageUrl: URL) {
        self.id = id
        self.title = title
        self.location = location
        self.date = date
        self.imageUrl = imageUrl
    }

    override func getCell(for tableView: ViewModelCellBasedTableView, at indexPath: IndexPath,
                          delegate: TableViewCellDelegateInterface?) -> UITableViewCell? {
        tableView.dequeueReusableCell(forceUnwrap: TableViewCell.self,
                                      for: indexPath) { [weak self] cell in
            guard let self = self else { return }
            cell.set(id: self.id, title: self.title, location: self.location, date: self.date, imageUrl: self.imageUrl)
        }
    }
}

// MARK: View

class EventTableViewCell: TableViewCell {

    private weak var titleLabel: UILabel!
    private weak var locationLabel: UILabel!
    private weak var dateLabel: UILabel!
    private weak var eventImageView: UIImageView!

    override func setup() {
        super.setup()
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 20
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let leftRightSpacing: CGFloat = 16
        stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: leftRightSpacing).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentView.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: leftRightSpacing).isActive = true

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        stackView.addArrangedSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        eventImageView = imageView

        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        stackView.addArrangedSubview(verticalStackView)

        titleLabel = addArrangedLabel(to: verticalStackView,
                                      font: .systemFont(ofSize: 17, weight: .semibold),
                                      textColor: .black)
        locationLabel = addArrangedLabel(to: verticalStackView,
                                         font: .systemFont(ofSize: 14, weight: .regular),
                                         textColor: .lightGray)
        dateLabel = addArrangedLabel(to: verticalStackView,
                                     font: .systemFont(ofSize: 14, weight: .regular),
                                     textColor: .lightGray)
    }

    private func addArrangedLabel(to stackView: UIStackView, font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.numberOfLines = 0
        label.textColor = textColor
        stackView.addArrangedSubview(label)
        return label
    }

    func set(id: Int, title: String, location: String, date: String, imageUrl: URL) {
        tag = id
        titleLabel.text = title
        locationLabel.text = location
        dateLabel.text = date
        Nuke.loadImage(with: imageUrl, into: eventImageView)
    }
}
