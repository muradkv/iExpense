//
//  ExpenseItem.swift
//  iExpense
//
//  Created by murad on 01.06.2026.
//

import Foundation
import SwiftData

@Model
final class ExpenseItem {
    var name: String
    var type: ExpenseType
    var typeName: String
    var amount: Double
    
    init(name: String, type: ExpenseType, typeName: String = "All", amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
        self.typeName = typeName
    }
}
