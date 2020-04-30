//
//  DemoTableViewCell.swift
//  KeyboardManagerDemo
//
//  Created by Edouard Siegel on 25/04/2019.
//

import UIKit
import ADUtils

class DemoTableViewCell: UITableViewCell, UITextFieldDelegate {

    var textField = UITextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Private

    private func commonInit() {
        addSubview(textField)
        textField.ad_pinToSuperview(insets: UIEdgeInsets(value: 16))
        textField.delegate = self
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
