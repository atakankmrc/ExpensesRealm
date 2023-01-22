//
//  TablesView.swift
//  ExpensesRealm
//
//  Created by Atakan Kömürcü on 22.01.2023.
//

import SwiftUI

struct TablesView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        VStack {
            Text("Expenses")
                .font(.title2).bold()
                .padding()
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            List {
                ForEach(realmManager.tables) { table in
                    Text(table.name)
                }
            }
            .background(Color.mint)
            
            Button("++++") {
                realmManager.addTable()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.mint)
    }
}

struct TablesView_Previews: PreviewProvider {
    static var previews: some View {
        TablesView()
            .environmentObject(RealmManager())
    }
}
