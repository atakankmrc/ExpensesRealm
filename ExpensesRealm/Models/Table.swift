//
//  Table.swift
//  ExpensesRealm
//
//  Created by Atakan Kömürcü on 22.01.2023.
//

import Foundation
import RealmSwift

class Table: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
}
