//
//  Current.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 27.02.23.
//

import Foundation


struct CurrentPriceEntry: Codable, Identifiable {
    let provider: String
    let last_updated: String
    let fuel: [Fuel]
    
    var id : String {
        return provider
    }
}

struct Fuel: Codable, Hashable {
    let name: String
    let type_alt: String
    let price: Float
    let change_rate: Float
    let date: String
    let last_updated: String
}
