//
//  UINavigationController+Swipe.swift
//  Twitter-iOS
//

import SwiftUI

extension UINavigationController {
  override open func viewDidLoad() {
    super.viewDidLoad()
    // Need to hide back button while keeping swipe back gesture.
    interactivePopGestureRecognizer?.delegate = nil
  }
}
