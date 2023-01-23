//
//  ExpensesView.swift
//  ExpensesRealm
//
//  Created by Atakan Kömürcü on 22.01.2023.
//

import SwiftUI

struct ExpensesView: View {
    
    
    @EnvironmentObject var realmManager: RealmManager
    @State var table: Table
    
    @State private var showAddExpense = false
    @State private var expenseName = ""
    @ObservedObject var expenseValue = NumbersOnly()
    
    @State private var expenses: [Expense] = []
    
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                VStack {
                    Text(expense.name)
                        .padding()
                    
                    Text("\(expense.value)")
                }
            }
        }
        
        Button("Add Expense", action: {
//            realmManager.addExpense(parentTable: table)
            expenses = realmManager.getExpensesByTable(table: table)
        })
        
        
        .sheet(isPresented: $showAddExpense, content: {
            TextField("Expense name", text: $expenseName)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            TextField("Value", text: $expenseValue.value)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Button("Add Expense", action: {
                realmManager.addExpense(name: expenseName, value: Int(expenseValue.value) ?? 0, parentTable: table)
                expenses = realmManager.getExpensesByTable(table: table)
                showAddExpense.toggle()
            })
        })
        
            .navigationBarTitle("\(table.name)")
            .navigationBarItems(trailing: Button("+", action: {
                showAddExpense.toggle()
            }))
            .onAppear {
                expenses = realmManager.getExpensesByTable(table: table)
            }
    }
}
