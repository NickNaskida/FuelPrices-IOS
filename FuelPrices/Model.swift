//
//  Model.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 23.02.23.
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
    let price: Double
    let change_rate: Int
    let date: String
    let last_updated: String
}
