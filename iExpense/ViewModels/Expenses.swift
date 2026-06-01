//
//  Expenses.swift
//  iExpense
//
//  Created by murad on 01.06.2026.
//

import SwiftUI

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var localCurrency: String {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    var personalItems: [ExpenseItem] {
        return items.filter { $0.type == .personal }
    }
    
    var businessItems: [ExpenseItem] {
        return items.filter { $0.type == .business }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    func removeItems(at offsets: IndexSet, as type: ExpenseType) {
        let currentArray = type == .personal ? personalItems : businessItems
        
        for offset in offsets {
            let itemToDelete = currentArray[offset]
            items.removeAll(where: { $0.id == itemToDelete.id })
        }
    }
}
