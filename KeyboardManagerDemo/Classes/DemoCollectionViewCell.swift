//
//  DemoCollectionViewCell.swift
//  KeyboardManagerDemo
//
//  Created by Edouard Siegel on 25/04/2019.
//

import UIKit

class DemoCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    var textField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Private

    private func commonInit() {
        addSubview(textField)
        textField.delegate = self
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.ad_pinToSuperview(insets: UIEdgeInsets(value: 16))
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
