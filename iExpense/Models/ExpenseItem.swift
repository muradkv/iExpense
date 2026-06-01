//
//  ExpenseItem.swift
//  iExpense
//
//  Created by murad on 01.06.2026.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}
