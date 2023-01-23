//
//  RealmManager.swift
//  ExpensesRealm
//
//  Created by Atakan Kömürcü on 22.01.2023.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    private(set) var localRealm: Realm?
    @Published private(set) var tables: [Table] = []
    @Published private(set) var expenses: [Expense] = []
    
    init() {
        openRealm()
        getTables()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 2)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
            
        } catch {
            print("Error opening realm: \(error)")
        }
    }
    
    func getTables() {
        if let localRealm = localRealm {
            let allTables = localRealm.objects(Table.self).sorted(byKeyPath: "isFavourite", ascending: false)
            tables = []
            allTables.forEach { table in
                tables.append(table)
            }
        }
    }
    
    func addTable(name: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write({
                    let newTable = Table(name: name)
                    localRealm.add(newTable)
                    getTables()
                })
            } catch {
                print("Error adding table \(error)")
            }
        }
    }
    
    func favouriteTable(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                let tableToFav = localRealm.objects(Table.self).filter(NSPredicate(format: "id == %@", id))
                guard !tableToFav.isEmpty else {return}
                try localRealm.write({
                    tableToFav[0].isFavourite.toggle()
                    getTables()
                })
            } catch {
                print("Error to favourite table: \(id) and \(error)")
            }
        }
    }
    
    func getExpensesByTable(table: Table) -> [Expense] {
        
        var tempExpenses: [Expense] = []
        
        if let localRealm = localRealm {
            let allExpenses = localRealm.objects(Expense.self).filter(NSPredicate(format: "parentTable == %@", table)).sorted(byKeyPath: "created")
            expenses = []
            allExpenses.forEach { expense in
                expenses.append(expense)
                tempExpenses.append(expense)
            }
        }
        return tempExpenses
    }
    
    func addExpense(name: String, value: Int, parentTable: Table) {
        
        if let localRealm = localRealm {
            do {
                try localRealm.write({
                    let newExpense = Expense(name: name, value: Double(value), created: Date(), tableId: Int(parentTable.id), parentTable: parentTable)
                    localRealm.add(newExpense)
                })
            } catch {
                print("Error adding table \(error)")
            }
        }
        
    }
    
}
