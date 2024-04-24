//
//  KeyboardUtills.swift
//  Venmo
//
//  Created by Burak Aksu on 4/24/24.
//

import UIKit

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
