//
//  Expense.swift
//  Venmo
//
//  Created by Burak Aksu on 4/24/24.
//

import RealmSwift
import SwiftUI

class Expense: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var amount: Double
    @Persisted var category: Category?
    @Persisted var date: Date
    @Persisted var note: String?
    @Persisted var recurrence: Recurrence? = Recurrence.none
    
    convenience init(amount: Double, category: Category, date: Date, note: String? = nil, recurrence: Recurrence? = nil) {
        self.init()
        self.amount = amount
        self.category = category
        self.date = date
        self.note = note
        self.recurrence = recurrence
    }
}


