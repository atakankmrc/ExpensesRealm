//
//  Expense.swift
//  ExpensesRealm
//
//  Created by Atakan Kömürcü on 22.01.2023.
//

import Foundation
import RealmSwift

class Expense: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    @Persisted var value: Double = 0.0
    @Persisted var created: Date
    @Persisted var tableId: Int
    @Persisted var parentTable: Table?
    
    convenience init(name: String, value: Double, created: Date, parentTable: Table) {
        self.init()
        self.name = name
        self.value = value
        self.created = Date()
        self.parentTable = parentTable
    }
    
}
