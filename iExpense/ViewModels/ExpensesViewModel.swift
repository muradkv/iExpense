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
    
    func personalItems(from items: [ExpenseItem]) -> [ExpenseItem] {
        items.filter { $0.type == .personal }
    }
    
    func businessItems(from items: [ExpenseItem]) -> [ExpenseItem] {
        items.filter { $0.type == .business }
    }
    
    func deleteItems(at offsets: IndexSet, from list: [ExpenseItem], context: ModelContext) {
        for offset in offsets {
            let itemToDelete = list[offset]
            context.delete(itemToDelete)
        }
        
        try? context.save()
    }
    
    func add(name: String, type: ExpenseType, amount: Double, context: ModelContext) {
        let newItem = ExpenseItem(
            name: name,
            type: type,
            typeName: type.rawValue,
            amount: amount
        )
        context.insert(newItem)
        try? context.save()
    }
}
