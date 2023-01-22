//
//  ContentView.swift
//  ExpensesRealm
//
//  Created by Atakan Kömürcü on 22.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var realmManager = RealmManager()
    
    @State private var showAddTableView = false
    @State private var newTableName = ""
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TablesView()
                .environmentObject(realmManager)
            
            AddTableButton()
                .padding()
                .onTapGesture {
                    showAddTableView.toggle()
                }
        }
        
        .sheet(isPresented: $showAddTableView) {
            
            Text("Tablo Ekle")
                .font(.title2).bold()
            
            TextField("Table Name", text: $newTableName)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button {
                realmManager.addTable(name: newTableName)
                newTableName = ""
                showAddTableView.toggle()
//                dismiss()
            } label: {
                Text("Add Table")
            }
            .frame(alignment: .leading)
            
            .presentationDetents([.fraction(0.3)])
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
