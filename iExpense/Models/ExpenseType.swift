//
//  ExpenseType.swift
//  iExpense
//
//  Created by murad on 30.05.2026.
//

import Foundation

enum ExpenseType: String, Codable, CaseIterable, Identifiable {
    case personal = "Personal"
    case business = "Business"
    
    var id: String { self.rawValue }
}
