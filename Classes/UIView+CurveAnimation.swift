//
//  UIView+CurveAnimation.swift
//  ADDynamicLogLevel
//
//  Created by Edouard Siegel on 25/04/2019.
//

import Foundation

extension UIView {
    class func animate(duration: TimeInterval,
                       curve: UIView.AnimationCurve,
                       animations: (() -> Void)?) {
        // TODO:(edouard siegel) 2019-05-02 Update to use UIView.animate
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(duration)
        UIView.setAnimationCurve(curve)
        animations?()
        UIView.commitAnimations()
    }
}
