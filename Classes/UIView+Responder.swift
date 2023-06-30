//
//  UIView+Responder.swift
//  ADDynamicLogLevel
//
//  Created by Edouard Siegel on 25/04/2019.
//

import UIKit

extension UIView {
    func findFirstResponder() -> UIView? {
        guard !isFirstResponder else {
            return self
        }
        for subview in subviews {
            if let responder = subview.findFirstResponder() {
                return responder
            }
        }
        return nil
    }
}
