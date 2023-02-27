//
//  Compare.swift
//  FuelPrices
//
//  Created by Nikoloz Naskidashvili on 27.02.23.
//

import Foundation


struct FuelTypeEntry: Codable, Identifiable, Hashable {
    let name: String
    let type_alt: String
    
    var id : String {
        return name
    }
}


struct CompareEntry: Codable, Identifiable, Hashable {
    let provider: String
    let price: Float
    
    var id : String {
        return provider
    }
}


