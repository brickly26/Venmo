//
//  Period.swift
//  Venmo
//
//  Created by Burak Aksu on 4/24/24.
//

import Foundation
import RealmSwift

enum Period: String, PersistableEnum, CaseIterable {
    case day = "Day"
    case week = "Week"
    case month = "Month"
    case year = "Year"
}
