//
//  ContentView.swift
//  iExpense
//
//  Created by murad on 25.05.2026.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

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
    
    func removePersonalItems(at offsets: IndexSet) {
        for offset in offsets {
            let itemToDelete = personalItems[offset]
            items.removeAll(where: { $0.id == itemToDelete.id })
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        for offset in offsets {
            let itemToDelete = businessItems[offset]
            items.removeAll(where: { $0.id == itemToDelete.id })
        }
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal Expenses") {
                    ForEach(expenses.personalItems) { item in
                        ExpenseRowView(
                            item: item,
                            localCurrency: expenses.localCurrency
                        )
                    }
                    .onDelete(perform: expenses.removePersonalItems)
                }
                
                Section("Business Expenses") {
                    ForEach(expenses.businessItems) { item in
                        ExpenseRowView(
                            item: item,
                            localCurrency: expenses.localCurrency
                        )
                    }
                    .onDelete(perform: expenses.removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
}

#Preview {
    ContentView()
}
