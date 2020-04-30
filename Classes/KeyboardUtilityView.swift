//
//  ADKeyboardUtilityView.swift
//  ADDynamicLogLevel
//
//  Created by Edouard Siegel on 25/04/2019.
//

import Foundation

protocol KeyboardUtilityView: AnyObject {
    func firstResponderView() -> UIView?
    func scroll(to view: UIView)
}

extension UIScrollView: KeyboardUtilityView {
    @objc func firstResponderView() -> UIView? {
        return findFirstResponder()
    }

    @objc func scroll(to view: UIView) {
        let target = convert(view.frame, from: view.superview)
        scrollRectToVisible(target, animated: true)
    }

}

extension UICollectionView {

    // swiftlint:disable:next override_in_extension
    @objc override func firstResponderView() -> UIView? {
        guard let cell = cellFromFirstResponder() else {
            return visibleCells.first
        }
        return cell
    }

    // swiftlint:disable:next override_in_extension
    @objc override func scroll(to view: UIView) {
        guard
            let cell = view as? UICollectionViewCell,
            let selectedRow = indexPath(for: cell) else {
                return
        }
        scrollToItem(at: selectedRow, at: [], animated: false)
    }

    // MARK: - Private

    private func cellFromFirstResponder() -> UIView? {
        guard
            let responder = findFirstResponder(),
            responder.conforms(to: UITextInput.self) else {
                return nil
        }
        return cell(forEditingView: responder)
    }

    private func cell(forEditingView textEditingView: UIView) -> UIView? {
        var view: UIView? = textEditingView
        while view != nil {
            if let cell = view as? UITableViewCell {
                return cell
            }
            view = view?.superview
        }
        return nil
    }
}

extension UITableView {

    // swiftlint:disable:next override_in_extension
    @objc override func firstResponderView() -> UIView? {
        guard let cell = cellFromFirstResponder() else {
            return visibleCells.first
        }
        return cell
    }

    // swiftlint:disable:next override_in_extension
    @objc override func scroll(to view: UIView) {
        guard
            let cell = view as? UITableViewCell,
            let selectedRow = indexPath(for: cell) else {
                return
        }
        scrollToRow(at: selectedRow, at: .none, animated: false)
    }

    // MARK: - Private

    private func cellFromFirstResponder() -> UITableViewCell? {
        guard
            let responder = findFirstResponder(),
            responder.conforms(to: UITextInput.self) else {
                return nil
        }
        return cell(forEditingView: responder)
    }

    private func cell(forEditingView textEditingView: UIView) -> UITableViewCell? {
        var view: UIView? = textEditingView
        while view != nil {
            if let cell = view as? UITableViewCell {
                return cell
            }
            view = view?.superview
        }
        return nil
    }

}
