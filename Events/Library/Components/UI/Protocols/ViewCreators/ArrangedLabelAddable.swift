//
//  ArrangedLabelAddable.swift
//  Events
//
//  Created by Vasily Bodnarchuk on 1/23/21.
//

import UIKit

protocol ArrangedLabelAddable: UIView {}

extension ArrangedLabelAddable {
    func addArrangedLabel(to stackView: UIStackView,
                          font: UIFont, textColor: UIColor,
                          numberOfLines: Int = 0,
                          textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = createLabel(font: font, textColor: textColor,
                                numberOfLines: numberOfLines,
                                textAlignment: textAlignment)
        stackView.addArrangedSubview(label)
        return label
    }

    func createLabel(font: UIFont,
                     textColor: UIColor = .black,
                     numberOfLines: Int = 0,
                     textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = font
        label.numberOfLines = numberOfLines
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
}
