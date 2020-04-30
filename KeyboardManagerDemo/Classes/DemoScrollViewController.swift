//
//  DemoScrollViewController.swift
//  KeyboardManagerDemo
//
//  Created by Edouard Siegel on 25/04/2019.
//

import UIKit
import ADKeyboardManager

class DemoScrollViewController: UIViewController, UITextFieldDelegate {

    private let scrollView = UIScrollView()
    private lazy var keyboardManager = KeyboardManager(scrollView: scrollView)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ScrollView Demo"
        setupScrollView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardManager.startObservingKeyboard()
    }

    override func viewWillDisappear(_ animated: Bool) {
        keyboardManager.stopObservingKeyboard()
        super.viewWillDisappear(animated)
    }

    // MARK: - Private

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.ad_pinToSuperview()
        var previousTextField: UITextField?
        for i in 1...10 {
            let textField = UITextField()
            textField.placeholder = String(format: "TextField %1d", i)
            textField.delegate = self
            scrollView.addSubview(textField)
            textField.ad_pinToSuperview(edges: [.left, .right], insets: UIEdgeInsets(value: 16))
            textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
            if let previous = previousTextField {
                textField.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 16).isActive = true
            } else {
                textField.ad_pinToSuperview(edges: [.top], insets: UIEdgeInsets(value: 16))
            }
            previousTextField = textField
        }
        previousTextField?.bottomAnchor
            .constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -16).isActive = true
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
