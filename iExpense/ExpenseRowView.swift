//
//  ExpenseRowView.swift
//  iExpense
//
//  Created by murad on 30.05.2026.
//

import SwiftUI

struct ExpenseRowView: View {
    let item: ExpenseItem
    let localCurrency: String
    
    var amountColor: Color {
        if item.amount < 10 {
            return .secondary
        } else if item.amount < 100 {
            return .primary
        } else {
            return .red
        }
    }
    
    var amountFont: Font {
        if item.amount >= 100 {
            return .headline.bold()
        } else {
            return .headline
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            
            Text(item.amount, format: .currency(code: localCurrency))
                .foregroundStyle(amountColor)
                .font(amountFont)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ExpenseRowView(item: ExpenseItem(name: "Coffee", type: "Personal", amount: 4.0), localCurrency: "USD")
        ExpenseRowView(item: ExpenseItem(name: "Dinner", type: "Personal", amount: 55.0), localCurrency: "USD")
        ExpenseRowView(item: ExpenseItem(name: "Flight", type: "Business", amount: 450.0), localCurrency: "USD")
    }
    .padding()

}
