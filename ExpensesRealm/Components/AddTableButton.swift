//
//  AddTableButton.swift
//  ExpensesRealm
//
//  Created by Atakan Kömürcü on 22.01.2023.
//

import SwiftUI

struct AddTableButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50)
                .foregroundColor(Color.blue)
            
            Text("+")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
        }
        .frame(width: 50)
    }
}

struct AddTableButton_Previews: PreviewProvider {
    static var previews: some View {
        AddTableButton()
    }
}
