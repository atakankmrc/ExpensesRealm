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
    
    @State private var totalExpense = 0.0
    
    var body: some View {
        
        Text("\(totalExpense.formatted(.currency(code: "TRY")))")
        
        List {
            ForEach(expenses) { expense in
                VStack(alignment: .leading) {
                    Text(expense.name)
                        .padding(.vertical)
                    
                    Text("\(expense.value.formatted(.currency(code: "TRY")))")
                }
            }
        }
        
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
                totalExpense = realmManager.getTotalExpenseByTable(table: table)
                showAddExpense.toggle()
            })
        })
        
            .navigationBarTitle("\(table.name)")
            .navigationBarItems(trailing: Button("+", action: {
                showAddExpense.toggle()
            }))
            .onAppear {
                expenses = realmManager.getExpensesByTable(table: table)
                totalExpense = realmManager.getTotalExpenseByTable(table: table)
            }
    }
}
