//
//  ExpensesViewModel.swift
//  iExpense
//
//  Created by murad on 01.06.2026.
//

import SwiftUI
import SwiftData

@Observable
final class ExpensesViewModel {
    var localCurrency: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    func delete(_ item: ExpenseItem, context: ModelContext) {
        context.delete(item)
    }
    
    func add(_ item: ExpenseItem, context: ModelContext) {
        context.insert(item)
    }
}
