//
//  Expense.swift
//  EXPENSE TRACKER
//
//  Created by Student on 28/09/26.
//

import SwiftData
import Foundation

@Model
class Expense {
    var amount: Double
    var category: String
    var note: String
    var date: Date

    init(amount: Double, category: String, note: String, date: Date) {
        self.amount = amount
        self.category = category
        self.note = note
        self.date = date
    }
}
