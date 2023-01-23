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
        NavigationView {
            VStack {
                    Text("Expenses")
                        .font(.title2).bold()
                        .padding()
                        .padding(.leading, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    List {
                        ForEach(realmManager.tables) { table in
                            NavigationLink(destination: ExpensesView(table: table).environmentObject(realmManager)) {
                                HStack {
                                    Text(table.name)
                                    Text(String(table.id))
                                    Spacer()
                                    if table.isFavourite {
                                        Label("", systemImage: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .frame(height: 30)
                                .swipeActions(edge: .leading) {
                                    Button {
                                        realmManager.favouriteTable(id: table.id)
                                    } label: {
                                        Label("Fav", systemImage: "star")
                                    }
                                    .tint(table.isFavourite ? .red : .yellow)
                                }
                            }
                        }
                    }
                    .onAppear {
                        UITableView.appearance().backgroundColor = .systemMint
                        UITableViewCell.appearance().backgroundColor = .systemMint
                    }
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.mint)
        }
    }
}

struct TablesView_Previews: PreviewProvider {
    static var previews: some View {
        TablesView()
            .environmentObject(RealmManager())
    }
}
