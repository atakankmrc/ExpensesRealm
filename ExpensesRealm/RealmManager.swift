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
    
    init() {
        openRealm()
        getTables()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
            
        } catch {
            print("Error opening realm: \(error)")
        }
    }
    
    func getTables() {
        if let localRealm = localRealm {
            let allTables = localRealm.objects(Table.self).sorted(byKeyPath: "name")
            tables = []
            allTables.forEach { table in
                tables.append(table)
            }
        }
    }
    
    func addTable() {
        if let localRealm = localRealm {
            do {
                try localRealm.write({
                    let newTable = Table(name: "Deneme")
                    localRealm.add(newTable)
                    getTables()
                })
            } catch {
                print("Error adding table \(error)")
            }
        }
    }
    
}
