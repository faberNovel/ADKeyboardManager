//
//  KeyboardAnimationParameters.swift
//  ADDynamicLogLevel
//
//  Created by Denis Poifol on 30/04/2020.
//

import Foundation

@objc public class KeyboardAnimationParameters: NSObject {
    public let animationCurve: UIView.AnimationCurve
    public let animationDuration: TimeInterval
    public let beginFrame: CGRect
    public let endFrame: CGRect
    public let isLocalUser: Bool

    init?(_ notification: NSNotification) {
        guard
            let animationCurve: UIView.AnimationCurve = notification[UIResponder.keyboardAnimationCurveUserInfoKey],
            let animationDuration: TimeInterval = notification[UIResponder.keyboardAnimationDurationUserInfoKey],
            let beginFrame: CGRect = notification[UIResponder.keyboardFrameBeginUserInfoKey],
            let endFrame: CGRect = notification[UIResponder.keyboardFrameEndUserInfoKey],
            let isLocalUser: Bool = notification[UIResponder.keyboardIsLocalUserInfoKey] else {
                return nil
        }
        self.animationCurve = animationCurve
        self.animationDuration = animationDuration
        self.beginFrame = beginFrame
        self.endFrame = endFrame
        self.isLocalUser = isLocalUser
        super.init()
    }
}

private extension NSNotification {
    subscript<T>(key: String) -> T? {
        return userInfo?[key] as? T
    }
}
