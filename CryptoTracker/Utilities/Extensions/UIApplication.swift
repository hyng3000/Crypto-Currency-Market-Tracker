//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Hamish Young on 27/3/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func appDismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
