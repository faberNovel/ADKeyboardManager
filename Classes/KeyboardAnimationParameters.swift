//
//  KeyboardAnimationParameters.swift
//  ADDynamicLogLevel
//
//  Created by Denis Poifol on 30/04/2020.
//

import UIKit

@objc public class KeyboardAnimationParameters: NSObject {
    public let animationOptions: UIView.AnimationOptions
    public let animationDuration: TimeInterval
    public let beginFrame: CGRect
    public let endFrame: CGRect
    public let isLocalUser: Bool

    init?(_ notification: NSNotification) {
        guard
            let animationCurve: NSNumber = notification[UIResponder.keyboardAnimationCurveUserInfoKey],
            let animationDuration: TimeInterval = notification[UIResponder.keyboardAnimationDurationUserInfoKey],
            let beginFrame: CGRect = notification[UIResponder.keyboardFrameBeginUserInfoKey],
            let endFrame: CGRect = notification[UIResponder.keyboardFrameEndUserInfoKey],
            let isLocalUser: Bool = notification[UIResponder.keyboardIsLocalUserInfoKey] else {
                return nil
        }
        // `animationCurve` cannot be cast into UIView.AnimationCurve because for 'some'
        // combinations of devices/os, the keyboard animation has a rawValue of 7 while
        // UIView.AnimationCurve only defines enumeration values up to 3.
        // This is an old and well-known issue, as stated here for example :
        // https://stackoverflow.com/q/19482573
        // One possible solution consists in turning .AnimationCurve into .AnimationOptions
        let animationCurveValue = animationCurve.uintValue
        self.animationOptions = UIView.AnimationOptions(
            rawValue: animationCurveValue << UIView.AnimationOptions.curveOptionsShift
        )
        self.animationDuration = animationDuration
        self.beginFrame = beginFrame
        self.endFrame = endFrame
        self.isLocalUser = isLocalUser
        super.init()
    }
}

private extension UIView.AnimationOptions {
    static let curveOptionsShift: UInt = {
        // Up of iOS13, curve options start at offset 16 in the AnimationOptions bitfield.
        // Instead of hard-coding this value, we prefer to retrieve it by calculating the
        // log2 of the first bitmask which stands for a curve option (namely .curveEaseIn).
        var start = UIView.AnimationOptions.curveEaseIn.rawValue
        var result: UInt = 0
        while start > 1 {
            result += 1
            start >>= 1
        }
        return result
    }()
}

private extension NSNotification {
    subscript<T>(key: String) -> T? {
        return userInfo?[key] as? T
    }
}
