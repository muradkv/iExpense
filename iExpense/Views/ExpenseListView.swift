//
//  ContentView.swift
//  iExpense
//
//  Created by murad on 25.05.2026.
//

import SwiftUI
import SwiftData

struct ExpenseListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query var items: [ExpenseItem]
    
    @State private var viewModel = ExpensesViewModel()
    @State private var showingAddExpense = false
    
    private var personalItems: [ExpenseItem] {
        items.filter { $0.type == .personal }
    }
    
    private var businessItems: [ExpenseItem] {
        items.filter { $0.type == .business }
    }
    
    var body: some View {
        NavigationStack {
            List {
                
                if !personalItems.isEmpty {
                    Section("Personal Expenses") {
                        ForEach(personalItems) { item in
                            ExpenseRowView(
                                item: item,
                                localCurrency: viewModel.localCurrency
                            )
                        }
                        .onDelete { offsets in
                            deleteItems(at: offsets, from: personalItems)
                        }
                    }
                }
                
                if !businessItems.isEmpty {
                    Section("Business Expenses") {
                        ForEach(businessItems) { item in
                            ExpenseRowView(
                                item: item,
                                localCurrency: viewModel.localCurrency
                            )
                        }
                        .onDelete { offsets in
                            deleteItems(at: offsets, from: businessItems)
                        }
                    }
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
            AddExpenseView(viewModel: viewModel)
        }
    }
    
    private func deleteItems(at offsets: IndexSet, from list: [ExpenseItem]) {
        for offset in offsets {
            let item = list[offset]
            viewModel.delete(item, context: modelContext)
        }
    }
}

#Preview {
    ExpenseListView()
}
