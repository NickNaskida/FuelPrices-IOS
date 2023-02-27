//
//  Lowest.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 27.02.23.
//

import Foundation

struct LowestPriceEntry: Codable, Identifiable {
    let fuel_type: String
    let price: Float
    let providers: [String]
    
    var id : String {
        return fuel_type + String(price) + providers.joined()
    }
}
