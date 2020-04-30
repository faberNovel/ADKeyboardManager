//
//  DemoTableViewController.swift
//  KeyboardManagerDemo
//
//  Created by Edouard Siegel on 25/04/2019.
//

import UIKit
import ADKeyboardManager

class DemoTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, KeyboardManagerDelegate {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private lazy var keyboardManager = createKeyboardManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TableView Demo"
        tableView.frame = view.frame
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cell: .class(DemoTableViewCell.self))
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

    private func createKeyboardManager() -> KeyboardManager {
        let animator = KeyboardManager(scrollView: tableView)
        animator.delegate = self
        return animator
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DemoTableViewCell = tableView.dequeueCell(at: indexPath)
        cell.selectionStyle = .none
        cell.textField.placeholder = String(format: "Row %1d", indexPath.row)
        return cell
    }

    // MARK: - ADKeyboardManagerDelegate

    func keyboardManager(_ animator: KeyboardManager,
                         performAdditionalAnimationOnKeyboardWillHide parameters: KeyboardAnimationParameters) {
        print("KeyboardManagerDelegate willHide")
    }

    func keyboardManager(_ animator: KeyboardManager,
                         performAdditionalAnimationOnKeyboardWillShow parameters: KeyboardAnimationParameters) {
        print("KeyboardManagerDelegate willShow")
    }
}
