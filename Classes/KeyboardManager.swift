//
//  ADKeyboardManager.swift
//  ADDynamicLogLevel
//
//  Created by Edouard Siegel on 25/04/2019.
//

import Foundation

/**
 `KeyboardManagerDelegate` enables to receive callbacks to perform supplementary changes inside the animation block.
 */
@objc(ADKeyboardManagerDelegate)
public protocol KeyboardManagerDelegate: AnyObject {
    func keyboardManager(_ animator: KeyboardManager,
                         performAdditionalAnimationOnKeyboardWillShow parameters: KeyboardAnimationParameters)
    func keyboardManager(_ animator: KeyboardManager,
                         performAdditionalAnimationOnKeyboardWillHide parameters: KeyboardAnimationParameters)
}

/**
 `KeyboardManager` is a class that automatically manage insets and scrolls through the `UIScrollView`
 it is initialized with, in order to keep the firstResponder view visible when keyboard appears or disappears.
 To use it properly you should create an instance of `KeyboardManager` and call :
 - `startObservingKeyboard` on the `viewWillAppear` of your viewController
 - `stopObservingKeyboard` on the `viewWillDisappear` of your viewController

 > If you want to perform additional animations on keyboard appearance and disappearance you should conform
 to `KeyboardManagerDelegate` in order to receive a callback at the appropriate time.
 */
@objc(ADKeyboardManager)
public class KeyboardManager: NSObject {
    public weak var delegate: KeyboardManagerDelegate?
    private let scrollView: UIScrollView
    private var initialBottomInset: CGFloat = 0
    private var initialScrollIndicatorBottomInset: CGFloat = 0
    private var keyboardIsVisible: Bool = false

    @objc public init(scrollView: UIScrollView) {
        self.scrollView = scrollView
    }

    /**
     The `KeyboardManager` will add itself as observer to the `NotificationCenter`
     for `keyboardWillShowNotification`as well as `keyboardWillHideNotification`
     */
    @objc(ad_startObservingKeyboard)
    public func startObservingKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIWindow.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIWindow.keyboardWillHideNotification,
            object: nil
        )
    }

    /**
     The `KeyboardManager` will remove itself from observers to the `NotificationCenter`
     for `keyboardWillShowNotification`as well as `keyboardWillHideNotification`
     */
    @objc(ad_stopObservingKeyboard)
    public func stopObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }

    // MARK: - Private

    @objc private func keyboardWillShow(_ notification: NSNotification) {
        defer {
            keyboardIsVisible = true
        }
        guard let parameters = KeyboardAnimationParameters(notification) else { return }
        let firstResponser = scrollView.firstResponderView()
        if !keyboardIsVisible {
            initialBottomInset = scrollView.contentInset.bottom
            initialScrollIndicatorBottomInset = scrollView.scrollIndicatorInsets.bottom
        }
        let keyboardFrame = scrollView.window?.convert(
            parameters.endFrame,
            to: scrollView.superview
        ) ?? .zero
        let newBottomInset = scrollView.frame.minY + scrollView.frame.height - keyboardFrame.minY
        guard newBottomInset > 0.0 else {
            return
        }
        animateScrollView(parameters,
                          newBottomInset: newBottomInset,
                          newScrollIndicatorBottomInset: newBottomInset
        ) { [weak self] in
            guard let self = self else { return }
            if let firstResponser = firstResponser {
                self.scrollView.scroll(to: firstResponser)
            }
            self.delegate?.keyboardManager(self, performAdditionalAnimationOnKeyboardWillShow: parameters)
        }
    }

    @objc private func keyboardWillHide(_ notification: NSNotification) {
        defer {
            keyboardIsVisible = false
        }
        guard let parameters = KeyboardAnimationParameters(notification) else { return }
        animateScrollView(parameters,
                          newBottomInset: initialBottomInset,
                          newScrollIndicatorBottomInset: initialScrollIndicatorBottomInset
        ) { [weak self] in
            guard let self = self else { return }
            self.delegate?.keyboardManager(self, performAdditionalAnimationOnKeyboardWillHide: parameters)
        }
    }

    private func animateScrollView(_ parameters: KeyboardAnimationParameters,
                                   newBottomInset: CGFloat,
                                   newScrollIndicatorBottomInset: CGFloat,
                                   completion: @escaping () -> Void) {
        var newContentInset = scrollView.contentInset
        var newScrollIndicatorInsets = scrollView.scrollIndicatorInsets
        newContentInset.bottom = newBottomInset
        newScrollIndicatorInsets.bottom = newScrollIndicatorBottomInset
        guard scrollView.contentInset != newContentInset else {
            return
        }
        UIView.animate(
            duration: parameters.animationDuration,
            curve: parameters.animationCurve
        ) { [weak self] in
            guard let self = self else { return }
            self.scrollView.contentInset = newContentInset
            self.scrollView.scrollIndicatorInsets = newScrollIndicatorInsets
            completion()
        }
    }
}
