//
//  AddView.swift
//  iExpense
//
//  Created by murad on 29.05.2026.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name = ""
    @State private var type = ExpenseType.personal
    @State private var amount = 0.0
    
    let viewModel: ExpensesViewModel
    
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
                
                TextField("Amount", value: $amount, format: .currency(code: viewModel.localCurrency))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    viewModel.add(
                        name: name,
                        type: type,
                        amount: amount,
                        context: modelContext
                    )
                    dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ExpenseItem.self, configurations: config)
    
    return AddExpenseView(viewModel: ExpensesViewModel())
        .modelContainer(container)
}
