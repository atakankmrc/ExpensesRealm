//
//  Utils.swift
//  ExpensesRealm
//
//  Created by Atakan Kömürcü on 23.01.2023.
//

import Foundation


class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
