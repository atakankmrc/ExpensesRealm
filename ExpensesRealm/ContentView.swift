//
//  ContentView.swift
//  ExpensesRealm
//
//  Created by Atakan Kömürcü on 22.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var realmManager = RealmManager()
    
    var body: some View {
        VStack {
            TablesView()
                .environmentObject(realmManager)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
