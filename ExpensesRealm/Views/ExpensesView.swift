//
//  ExpensesView.swift
//  ExpensesRealm
//
//  Created by Atakan Kömürcü on 22.01.2023.
//

import SwiftUI

struct ExpensesView: View {
    
    
//    @EnvironmentObject var realmManager: RealmManager
    @State var table: Table
    
    var body: some View {
        Text(table.name)
        
            .navigationBarTitle("\(table.name)")
    }
}
