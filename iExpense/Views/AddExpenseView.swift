//
//  AddView.swift
//  iExpense
//
//  Created by murad on 29.05.2026.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = ExpenseType.personal
    @State private var amount = 0.0
    
    let expenses: Expenses
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(ExpenseType.allCases) {
                        Text($0.rawValue)
                            .tag($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: expenses.localCurrency))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.addItem(item)
                    dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
    }
}

#Preview {
    AddExpenseView(expenses: Expenses())
}
