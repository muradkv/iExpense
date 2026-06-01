//
//  ContentView.swift
//  iExpense
//
//  Created by murad on 25.05.2026.
//

import SwiftUI

struct ExpenseListView: View {
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
            AddExpenseView(expenses: expenses)
        }
    }
}

#Preview {
    ExpenseListView()
}
