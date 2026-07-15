//
//  ExpenseSectionListView.swift
//  iExpense
//
//  Created by murad on 14.07.2026.
//

import SwiftUI
import SwiftData

struct ExpenseSectionListView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query var items: [ExpenseItem]
    let viewModel: ExpensesViewModel
    
    private var personalItems: [ExpenseItem] {
        viewModel.personalItems(from: items)
    }
    
    private var businessItems: [ExpenseItem] {
        viewModel.businessItems(from: items)
    }
    
    init(sortOrder: [SortDescriptor<ExpenseItem>], viewModel: ExpensesViewModel) {
        _items = Query(sort: sortOrder)
        self.viewModel = viewModel
    }
    
    var body: some View {
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
                        viewModel.deleteItems(at: offsets, from: personalItems, context: modelContext)
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
                        viewModel.deleteItems(at: offsets, from: businessItems, context: modelContext)
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ExpenseItem.self, configurations: config)
    
    let sample1 = ExpenseItem(name: "Coffee", type: .business, amount: 4.0)
    let sample2 = ExpenseItem(name: "Dinner", type: .personal, amount: 55.0)
    
    container.mainContext.insert(sample1)
    container.mainContext.insert(sample2)
    
    return ExpenseSectionListView(
        sortOrder: [SortDescriptor(\ExpenseItem.name)],
        viewModel: ExpensesViewModel()
    )
    .modelContainer(container)
}
