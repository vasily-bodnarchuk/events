//
//  ArrangedLabelAddable.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

protocol ArrangedLabelAddable: UIView {}

extension ArrangedLabelAddable {
    func addArrangedLabel(to stackView: UIStackView, font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.font = font
        label.numberOfLines = 0
        label.textColor = textColor
        stackView.addArrangedSubview(label)
        return label
    }
}
