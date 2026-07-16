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
    
    @State private var viewModel = ExpensesViewModel()
    @State private var showingAddExpense = false
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount, order: .reverse)
    ]
    
    @State private var filter = "All"
    
    var body: some View {
        NavigationStack {
            ExpenseSectionListView(
                sortOrder: sortOrder,
                filter: filter,
                viewModel: viewModel
            )
                .navigationTitle("iExpense")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort Order", selection: $sortOrder) {
                                Text("Sort by Name")
                                    .tag([
                                        SortDescriptor(\ExpenseItem.name),
                                        SortDescriptor(\ExpenseItem.amount, order: .reverse)
                                    ])
                                
                                Text("Sort by Amount")
                                    .tag([
                                        SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                        SortDescriptor(\ExpenseItem.name)
                                    ])
                            }
                            
                            Picker("Filter Category", selection: $filter) {
                                Text("Show All")
                                        .tag("All")
                                    
                                    Text("Personal Only")
                                        .tag("Personal")
                                    
                                    Text("Business Only")
                                        .tag("Business")
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Expense", systemImage: "plus") {
                            showingAddExpense = true
                        }
                    }
                }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddExpenseView(viewModel: viewModel)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ExpenseItem.self, configurations: config)
    
    let sample1 = ExpenseItem(name: "Coffee", type: .business, amount: 4.0)
    let sample2 = ExpenseItem(name: "Dinner", type: .personal, amount: 55.0)
    let sample3 = ExpenseItem(name: "Dance", type: .personal, amount: 155)
    
    container.mainContext.insert(sample1)
    container.mainContext.insert(sample2)
    container.mainContext.insert(sample3)
    
    return ExpenseListView()
        .modelContainer(container)
}
